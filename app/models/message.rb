class Message < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  before_save :unread_chat, :send_message_email
  belongs_to :chat
  belongs_to :user

  validates_presence_of :body, :chat_id, :user_id

  scope :unread, -> { where(readed: false) }

  def unread_chat
    chat.update_attributes(readed: false)
  end

  def send_message_email
    regex = /minute/
    recipient = get_email_recipient

    return MessageMailer.inbox(self, recipient).deliver_later if Chat.last.messages.last(2).empty?
    
    t = distance_of_time_in_words(chat.messages.last(2).first.created_at, Time.now)

    if !(regex =~ t).nil?  && t.to_i >= 10
      MessageMailer.inbox(self, recipient).deliver_later
    end
  end

  # get the email recipient
  def get_email_recipient
    user == chat.sender ? chat.recipient : chat.sender
  end
end
