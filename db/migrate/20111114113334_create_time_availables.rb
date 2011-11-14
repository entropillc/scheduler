class CreateTimeAvailables < ActiveRecord::Migration
  def change
    create_table :time_availables do |t|
      t.string :name
      t.integer :display_order

      t.timestamps
    end
  end
end
