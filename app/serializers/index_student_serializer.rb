class IndexStudentSerializer < ActiveModel::Serializer
	attributes :id, :email, :name, :student_last_schedule
	
	# Displays full student's full name.
	def name
		object.first_name + " " + object.last_name 
	end

	# Shows last student's schedule
  def student_last_schedule
  	object.schedules.last
  end
end