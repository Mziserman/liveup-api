class AnswerVote < ApplicationRecord

  after_commit do
    ActionCable
      .server
      .broadcast("stream_#{answer.stream_id}_question_channel",
                 id: answer.id,
                 user_id: answer.user_id,
                 created_at: answer.created_at,
                 score: answer.answer_votes_count,
                 content: answer.content,
                 pseudo: answer.user.pseudo)
  end

  validates :user, uniqueness: { scope: :answer }

  belongs_to :user
  belongs_to :answer, touch: true, counter_cache: true
end
