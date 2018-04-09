class ChatMessage < ApplicationRecord
  after_create_commit do
    ActionCable
      .server
      .broadcast('chat_channel',
                 id: id,
                 created_at: created_at.strftime('%H:%M'),
                 content: content)
  end

  belongs_to :stream
  belongs_to :user
end
