class QuestionVote < ApplicationRecord

  after_commit do
    ActionCable
      .server
      .broadcast("stream_#{question.stream_id}_question_channel",
                 id: question.id,
                 user_id: question.user_id,
                 created_at: question.created_at,
                 score: question.question_votes_count,
                 content: question.content,
                 pseudo: question.user.pseudo)
  end

  validates :user, uniqueness: { scope: :question }

  belongs_to :user
  belongs_to :question, touch: true, counter_cache: true
end
