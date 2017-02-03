class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :activated, :created_at, :updated_at
end
