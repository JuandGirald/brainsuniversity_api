class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id

  belongs_to :user
end
