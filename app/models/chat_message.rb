class ChatMessage < ApplicationRecord
  after_create_commit do
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_channel",
                 id: id,
                 created_at: created_at.strftime('%H:%M'),
                 content: content,
                 pseudo: user.pseudo)
  end

  belongs_to :stream
  belongs_to :user
end
