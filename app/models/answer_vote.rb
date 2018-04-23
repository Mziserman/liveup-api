class AnswerVote < ApplicationRecord

  after_commit do
    answer.question.broadcast
  end

  validates :user, uniqueness: { scope: :answer }

  belongs_to :user
  belongs_to :answer, touch: true, counter_cache: true
end
