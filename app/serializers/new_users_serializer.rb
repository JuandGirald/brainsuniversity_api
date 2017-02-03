class NewUsersSerializer < UserSerializer
  attributes :id, :email, :role, :token, :activated,
  						:created_at, :updated_at
end