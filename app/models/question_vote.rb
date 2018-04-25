class QuestionVote < ApplicationRecord

  after_commit do
    question.broadcast
  end

  validates :user, uniqueness: { scope: :question }

  belongs_to :user
  belongs_to :question, touch: true, counter_cache: true
end
