class User < ApplicationRecord
	include TokenProvider
	has_secure_password

	has_many :chats, foreign_key: :sender_id

	after_create :set_auth_token 
	before_create :create_activation_digest
	validates :password, length: { minimum: 6 }, on: :create
 	validates :email, uniqueness: true, email_format: true
 	validates :first_name, :last_name, presence: true

 	attr_accessor :activation_token

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

	def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

	def activate
	  update_columns(activated: true, activated_at: Time.zone.now)
	end

	# Check Unactives teachers users
	def user_active?
		return true if teacher? && !activated
	end

	private
		def create_activation_digest
			self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
		end
end
