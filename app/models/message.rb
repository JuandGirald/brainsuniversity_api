class Message < ApplicationRecord
  before_save :unread_chat
  belongs_to :chat
  belongs_to :user

  validates_presence_of :body, :chat_id, :user_id

  scope :unread, -> { where(readed: false) }

  def unread_chat
    chat.update_attributes(readed: false)
  end
end
