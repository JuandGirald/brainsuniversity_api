class Teacher < User
	before_create :set_role, :set_status
	
	has_one :profile, inverse_of: :teacher
	accepts_nested_attributes_for :profile

	enum status: { pending: '1', 
								 accepted: '2',
               	 rejected: '3',
               	 waiting: '4'
							 }

	#							 
	# set the user to wait for approval
	# send email to schedule an appointment
	def schedule_step
		self.waiting!
		UserMailer.schedule_step(self).deliver_now
	end

	private
		def set_role
			self.role = 'teacher'
		end

		def set_status
			self.status = 'pending'
		end
end