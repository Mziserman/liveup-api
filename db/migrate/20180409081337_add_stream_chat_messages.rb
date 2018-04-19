class AddStreamChatMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :chat_messages, :stream, index: true
    add_reference :chat_messages, :user, index: true
  end
end
