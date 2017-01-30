class Student < User
	before_save :set_role

	def set_role
		self.role = 'student'
	end
end