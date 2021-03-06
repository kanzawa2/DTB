class TimeEntry < ActiveRecord::Base
  belongs_to :task
  default_scope { order(created_at: :desc) }

  def self.recording?
    @current_time_entry.present?
  end

  def self.current
    @current_time_entry
  end

  def self.current=(time_entry)
    @current_time_entry = time_entry
  end

  def self.start(options, task_id)
    return nil if TimeEntry.recording?

    # For stand alone
    unless TOGGL_API_CLIENT.present?
      return TimeEntry.current = TimeEntry.create(name: options[:description],
                                                  start_time: Time.current,
                                                  task_id: task_id)
    end

    # For cooperating with Toggl
    response = TOGGL_API_CLIENT.start_time_entry(options)
    TimeEntry.current = TimeEntry.create(name: response.description,
                                         start_time: Time.zone.parse(response.start),
                                         task_id: task_id,
                                         toggl_time_entry_id: response.id)
  end

  def self.stop
    return false unless TimeEntry.recording?

    # For cooperating with Toggl
    TOGGL_API_CLIENT.stop_time_entry(TimeEntry.current.toggl_time_entry_id) if TOGGL_API_CLIENT.present?

    time_entry = TimeEntry.current
    TimeEntry.current = nil
    time_entry.end_time = Time.current
    time_entry.save
  end

  def self.partial_sync(start_date, end_date)
    return false unless TOGGL_API_CLIENT.present?

    toggl_time_entries = TOGGL_API_CLIENT.get_time_entries(start_date, end_date)
    toggl_time_entries.each do |toggl_time_entry|
      dtb_time_entry = TimeEntry.find_by(toggl_time_entry_id: toggl_time_entry.id)
      if dtb_time_entry
        dtb_time_entry.sync
      else
        TimeEntry.create(name: toggl_time_entry.description,
                         start_time: toggl_time_entry.start,
                         end_time: toggl_time_entry.stop,
                         toggl_time_entry_id: toggl_time_entry.id)
      end
    end
  end

  def self.completely_sync
    # Toggl API does not provide API to get all time entries
    # but provide API to get time entries started in a specific time range.
    # Service of Toggl is started at 2006.
    # So, in order to get all time entries, "2006-01-01" is used.
    TimeEntry.partial_sync(Time.utc('2006-01-01'), nil)
  end

  def duration
    Duration.new(start_time, end_time)
  end

  def unified_histories
    UnifiedHistory.overlap(duration)
  end

  delegate :file_histories, to: :unified_histories

  delegate :web_histories, to: :unified_histories

  def integrated_histories
    IntegratedHistory.integrate(unified_histories)
  end

  def restore
    unified_histories.map(&:restore)
  end

  # FIXME: This method cannot sync running time entry
  #   because it's end_time is nil.
  def sync
    return unless TOGGL_API_CLIENT.present?

    toggl_time_entry = TOGGL_API_CLIENT.get_time_entry(toggl_time_entry_id)
    if toggl_time_entry.server_deleted_at
      destroy
    else
      if Time.zone.parse(toggl_time_entry.at) > updated_at
        self.name = toggl_time_entry.description
        self.start_time = toggl_time_entry.start
        self.end_time = toggl_time_entry.stop
        save
      else
        options = {
          description: name,
          start:       start_time.iso8601,
          stop:        end_time.iso8601,
          duration:    duration.to_seconds
        }
        TOGGL_API_CLIENT.update_time_entry(toggl_time_entry_id, options)
      end
    end
  end

  def to_occurrence
    {
      id:        id,
      title:     name,
      start:     start_time.iso8601,
      end:       end_time.iso8601,
      type:      'time-entry',
      className: 'time-entry-occurrence'
    }
  end
end
