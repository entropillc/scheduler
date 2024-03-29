class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :customer_name
      t.integer :customer_id
      t.date :event_date
      t.text :notes
      t.integer :room_id
      t.integer :party_type
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
