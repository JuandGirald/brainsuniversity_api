class User < ApplicationRecord
	include TokenProvider
	has_secure_password

	after_create :set_auth_token 
	validates :password, length: { minimum: 6 }, on: :create
 	validates :email, uniqueness: true, email_format: true

 	enum role: { admin: '1',
               teacher: '2',
               student: '3'
             }

	def represent_user_with_token(token=nil)
		token ||= ::TokenProvider.encode(
	    user_id: self.id
	  )
	  self.update(token: token)
	end

	def set_auth_token
		return if token.present?
	  represent_user_with_token
	end

	def delete_token
		self.update(token: nil)
	end
end
