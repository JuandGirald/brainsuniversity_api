class ChatSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :recipient_id, :recipient_email, :sender_email, 
             :sender_name, :recipient_name, :last_message, :readed, :updated_at

  #Displays sender's message full name
  def sender_name
    object.sender.first_name + " " + object.sender.last_name
  end

  def sender_email
    object.sender.email
  end

  def recipient_email
    object.recipient.email
  end

  def updated_at
    object.updated_at.to_formatted_s(:short)
  end

  #Displays recipient's message full name
  def recipient_name
    object.recipient.first_name + " " + object.recipient.last_name
  end

  def last_message
    object.messages.last.body
  end

end
