class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :dob, :phone, :address, :gender, 
  						:city, :country, :university, :level, 
  						:about, :rate
end
