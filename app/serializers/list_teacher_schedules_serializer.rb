class ListTeacherSchedulesSerializer < ActiveModel::Serializer
	attributes :id, :start_at, :modality, :status,
						 :duration, :student_name, :student_email

end