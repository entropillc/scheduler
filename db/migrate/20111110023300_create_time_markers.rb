class CreateTimeMarkers < ActiveRecord::Migration
  def change
    create_table :time_markers do |t|
      t.integer :marker
      t.integer :event_id
      t.integer :room_id
      t.string :customer
      t.date :marker_date

      t.timestamps
    end
  end
end
