class AddIndexToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :teacher_id, :integer
    add_index :profiles, :teacher_id
    add_column :profiles, :student_id, :integer
    add_index :profiles, :student_id
  end
end
