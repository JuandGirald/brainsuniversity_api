class Teacher < User
	before_save :set_role

	def set_role
		self.role = 'teacher'
	end
end