class Admin < User
	before_create :set_role

	def set_role
		self.role = 'admin'
	end
end