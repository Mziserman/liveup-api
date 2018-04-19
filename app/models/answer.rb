class Answer < ApplicationRecord
  after_commit do
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_question_channel",
                 id: id,
                 user_id: user_id,
                 created_at: created_at,
                 score: answer_votes_count,
                 content: content,
                 pseudo: user.pseudo)
  end

  default_scope { order(answer_votes_count: :desc) }

  has_many :answer_votes
  belongs_to :question
  belongs_to :stream
  belongs_to :user
end
