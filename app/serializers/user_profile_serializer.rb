class UserProfileSerializer < UserSerializer
	attributes :id, :email, :role, :first_name, :last_name,
  						:activated, :status

  has_one :profile
  has_one :bank_information
end