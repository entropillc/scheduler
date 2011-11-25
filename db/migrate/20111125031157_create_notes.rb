class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.date :note_date
      t.text :body

      t.timestamps
    end
  end
end
