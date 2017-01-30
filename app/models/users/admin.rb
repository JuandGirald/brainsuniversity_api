class Admin < User
	before_save :set_role

	def set_role
		self.role = 'admin'
	end
end