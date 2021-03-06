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
                 color: user.color,
                 avatar: user.avatar.url,
                 answers: answers.map {|answer|
                  {
                    id: answer.id,
                    pseudo: answer.user.pseudo,
                    color: answer.user.color,
                    score: answer.answer_votes_count,
                    content: answer.content,
                    user_id: answer.user_id
                  }
                 })
  end

  default_scope { order(question_votes_count: :desc) }

  has_many :question_votes
  has_many :answers
  belongs_to :stream
  belongs_to :user
end
