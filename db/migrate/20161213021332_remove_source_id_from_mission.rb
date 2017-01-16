class RemoveSourceIdFromMission < ActiveRecord::Migration
  def change
    remove_column :missions, :source_id, :integer
  end
end
