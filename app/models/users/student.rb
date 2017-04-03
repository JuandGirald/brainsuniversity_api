class Student < User
	before_create :set_role

	has_one :profile, inverse_of: :student
	has_many :schedules, inverse_of: :student
	accepts_nested_attributes_for :profile
	
	private
		def set_role
			self.role = 'student'
		end

		# Displays full student's full name.
		def name
			first_name + " " + last_name 
		end

		# Shows last student's schedule
	  def student_last_schedule
	  	schedules.last.start_at
	  end

end