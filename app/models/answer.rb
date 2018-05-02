class Answer < ApplicationRecord
  after_commit do
    question.broadcast
  end

  default_scope { order(answer_votes_count: :desc) }

  has_many :answer_votes
  belongs_to :question
  belongs_to :stream
  belongs_to :user
end
