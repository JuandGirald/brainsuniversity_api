class CreateTeacherStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_students do |t|
      t.belongs_to :teacher, index: true
      t.belongs_to :student, index: true
      t.timestamps
    end
  end
end
