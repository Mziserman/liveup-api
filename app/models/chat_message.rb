class ChatMessage < ApplicationRecord
  after_create_commit do
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_chat_channel",
                 id: id,
                 user_id: user_id,
                 created_at: created_at,
                 content: content,
                 pseudo: user.pseudo)
  end

  default_scope { order(created_at: :asc) }

  belongs_to :stream
  belongs_to :user
end
