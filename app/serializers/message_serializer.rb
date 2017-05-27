class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id, :created_at

  belongs_to :user
end
