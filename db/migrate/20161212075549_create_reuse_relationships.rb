class CreateReuseRelationships < ActiveRecord::Migration
  def change
    create_table :reuse_relationships do |t|
      t.integer :source_id
      t.integer :destination_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
