class QuestionVote < ApplicationRecord
  validates :user, uniqueness: { scope: :question }

  belongs_to :user
  belongs_to :question, touch: true, counter_cache: true
end
