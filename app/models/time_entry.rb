class TimeEntry < ActiveRecord::Base
  belongs_to :task

  def self.initialize_api_base
    toggl_api_token = YAML.load_file("local/toggl.yml")
    return Toggl::Base.new(toggl_api_token["toggl_api_token"])
  end

  def self.start(options)
    base = initialize_api_base
    return base.start_time_entry(options)
  end

  def self.running_time_entry
    return TimeEntry.where(["running_status = ?", true])
  end

  def self.import
    base = initialize_api_base
    base.get_time_entries(Time.parse(base.me["created_at"]), Time.now).each do |te|
      if TimeEntry.where(["toggl_time_entry_id = ?", te["id"]]).blank?
        time_entry = TimeEntry.new({name: te["description"], start_time: Time.parse(te["start"]),
                                     end_time: Time.parse(te["start"]) + te["duration"],
                                     toggl_time_entry_id: te["id"],
                                     running_status: te["duration"] >= 0 ? false : true})
      else
        time_entry = TimeEntry.where(["toggl_time_entry_id = ?", te["id"]]).first
        time_entry.update({name: te["description"], start_time: Time.parse(te["start"]),
                                     end_time: Time.parse(te["start"]) + te["duration"],
                                     running_status: te["duration"] >= 0 ? false : true})
      end
      time_entry.save
    end
  end

  def stop
    base = TimeEntry.initialize_api_base
    return base.stop_time_entry(self.toggl_time_entry_id)
  end

  def duration
    return {"start_time" => start_time, "end_time" => end_time}
  end

  def unified_histories
    return UnifiedHistory.where(["start_time >= ? and start_time <= ? or end_time >= ? and end_time <= ?",
                                 start_time, end_time, start_time, end_time])
  end
end