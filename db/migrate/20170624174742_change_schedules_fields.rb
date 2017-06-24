class ChangeSchedulesFields < ActiveRecord::Migration[5.0]
  def change
    change_column :schedules, :teacher_id, 'integer USING CAST(teacher_id AS integer)'
    change_column :schedules, :student_id, 'integer USING CAST(student_id AS integer)'
  end
end
