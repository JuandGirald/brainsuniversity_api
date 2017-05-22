class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :activated, :first_name, :last_name,
              :created_at, :updated_at, :subjects

  has_one :profile
  has_one :availability
end