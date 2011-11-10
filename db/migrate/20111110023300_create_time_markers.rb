class CreateTimeMarkers < ActiveRecord::Migration
  def change
    create_table :time_markers do |t|
      t.integer :marker
      t.integer :event_id
      t.integer :room_id

      t.timestamps
    end
  end
end
