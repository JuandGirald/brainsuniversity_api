class Student < User
	before_create :set_role

	has_one :profile, inverse_of: :student
	has_many :schedules, inverse_of: :student
	accepts_nested_attributes_for :profile
	
	private
		def set_role
			self.role = 'student'
		end
end