class ChatSerializer < ActiveModel::Serializer
	attributes :id, :sender_id, :recipient_id, :sender_name, :recipient_name

	#Displays sender's message full name
	def sender_name
		object.sender.first_name + " " + object.sender.last_name
	end

	#Displays recipient's message full name
	def recipient_name
		object.recipient.first_name + " " + object.recipient.last_name
	end

	has_many :messages

end
