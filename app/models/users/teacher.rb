class Teacher < User
	before_create :set_role, :set_status
	
	has_one :profile, inverse_of: :teacher
	accepts_nested_attributes_for :profile

	enum status: { pending: '1', 
								 accepted: '2',
               	 rejected: '3'
							 }

	private
		def set_role
			self.role = 'teacher'
		end

		def set_status
			self.status = 'pending'
		end
end