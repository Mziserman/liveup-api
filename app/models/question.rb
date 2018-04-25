class Question < ApplicationRecord
  after_commit :broadcast

  def broadcast
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_question_channel",
                 id: id,
                 user_id: user_id,
                 created_at: created_at,
                 score: question_votes_count,
                 content: content,
                 pseudo: user.pseudo,
                 answers: answers)
  end

  default_scope { order(question_votes_count: :desc) }

  has_many :question_votes
  has_many :answers
  belongs_to :stream
  belongs_to :user
end
