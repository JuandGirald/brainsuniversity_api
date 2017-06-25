class AddReadFieldToChatsAndMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :readed, :boolean, default: false
    add_column :messages, :readed, :boolean, default: false
  end
end
