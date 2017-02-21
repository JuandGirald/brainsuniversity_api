class BankSerializer < ActiveModel::Serializer
	attributes :id, :teacher_id, :owner_id, :account_number,
						 :bank_name, :account_type, :owner_name
end