class Chat < ApplicationRecord
	belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  
  validates_presence_of :recipient_id, :sender_id  
  has_many :messages, dependent: :destroy


  # scope :involving, -> (user) do
  #   where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  # end

  scope :unread, -> { where(readed: false) }
  scope :between, -> (sender_id,recipient_id) do
    where("(chats.sender_id = ? AND chats.recipient_id =?) 
      OR (chats.sender_id = ? AND chats.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  def check_unread_messages(current_user)
    if current_user != messages.last.user
      messages.unread.update_all(readed: true)
      self.update_attributes(readed: true)
    end
  end
end
