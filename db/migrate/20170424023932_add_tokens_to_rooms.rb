class AddTokensToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :student_token, :string, :limit => 10000
    add_column :rooms, :teacher_token, :string, :limit => 10000
  end
end
