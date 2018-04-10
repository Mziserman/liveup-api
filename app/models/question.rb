class Question < ApplicationRecord
  after_commit do
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_question_channel",
                 id: id,
                 user_id: user_id,
                 created_at: created_at,
                 score: score,
                 content: content,
                 pseudo: user.pseudo)
  end

  belongs_to :stream
  belongs_to :user
end
