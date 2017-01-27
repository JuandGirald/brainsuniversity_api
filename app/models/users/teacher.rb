class Teacher < User
	authenticates_with_sorcery!

	before_save :set_role

	def set_role
		self.role = 'teacher'
	end
end