class User < ApplicationRecord
	include TokenProvider
	authenticates_with_sorcery!

	after_create :set_auth_token 
	validates :password, length: { minimum: 6 }, on: :create
 	validates :email, uniqueness: true, email_format: true

 	enum role: { admin: '1',
               teacher: '2',
               student: '3'
             }

	def represent_user_with_token
	  self.update(token: ::TokenProvider.issue_token(
	    user_id: self.id
	  ))
	end

	def set_auth_token
		return if token.present?
	  represent_user_with_token
	end

	def delete_token
		self.update(token: nil)
	end

	def as_json(options={})
 		options[:except] ||= [:token, :crypted_password, :salt]
 		super(options)
	end
end
