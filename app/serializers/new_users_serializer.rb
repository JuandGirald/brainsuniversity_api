class NewUsersSerializer < UserSerializer
  attributes :id, :email, :role, :created_at, :updated_at, :token
end