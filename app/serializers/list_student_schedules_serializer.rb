class ListStudentSchedulesSerializer < ActiveModel::Serializer
	attributes :id, :start_at, :modality, :status,
						 :duration, :teacher_name, :teacher_email

end