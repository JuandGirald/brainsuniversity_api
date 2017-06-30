class ListSchedulesSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :modality, :status,
             :duration, :student_name, :student_email, :student_id,
             :teacher_name, :teacher_email, :teacher_id
             
  has_one :order
  # returns student's name and Email
  def start_at
    object.start_at.to_formatted_s(:short)
  end

  def student_id
    object.student.id
  end

  def teacher_id
    object.teacher.id
  end

  def student_name
    object.student.first_name + " " + object.student.last_name
  end

  #returns teacher's name and Email
  def teacher_name
    object.teacher.first_name + " " + object.teacher.last_name 
  end
end