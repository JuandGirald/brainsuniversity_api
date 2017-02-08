class NewUsersSerializer < UserSerializer
  attributes :id, :email, :role, :token, :first_name, :last_name,
  						:activated, :created_at
end