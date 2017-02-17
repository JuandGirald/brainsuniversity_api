class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :schedule_id
      t.string :session_id

      t.timestamps
    end
    add_index :rooms, :schedule_id
  end
end
