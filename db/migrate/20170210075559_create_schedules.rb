class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :teacher_id
      t.string :student_id
      t.string :duration
      t.string :modality
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    add_index :schedules, :teacher_id
    add_index :schedules, :student_id
  end
end
