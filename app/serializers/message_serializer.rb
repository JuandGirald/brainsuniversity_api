class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id, :created_at, :readed

  belongs_to :user
end
