class AddColumnToMission < ActiveRecord::Migration
  def change
    add_column :missions, :children_count, :integer, :null => false, :default => 0
  end
end
