class IndexStudentSerializer < ActiveModel::Serializer
	attributes :id, :email, :name, :student_last_schedule
end