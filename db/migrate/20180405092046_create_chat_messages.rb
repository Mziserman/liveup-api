class CreateChatMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_messages do |t|
      t.text :content
      # t.references :user

      t.timestamps
    end
  end
end
