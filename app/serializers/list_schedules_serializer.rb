class ListSchedulesSerializer < ActiveModel::Serializer
	attributes :id, :start_at, :modality, :status,
						 :duration, :student_name, :student_email, :teacher_name, :teacher_email
						 
  has_one :order
	# returns student's name and Email
	def student_name
    object.student.first_name + " " + object.student.last_name
  end

  #returns teacher's name and Email
	def teacher_name
    object.teacher.first_name + " " + object.teacher.last_name 
  end
end