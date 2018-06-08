class Api::V1::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :score,
             :pseudo,
             :answers,
             :color,
             :avatar,
             :user_id,
             :created_at

  def score
    @object.question_votes_count
  end

  def pseudo
    @object.user.pseudo
  end

  def avatar
    @object.user.avatar.url
  end

  def answers
    @object.answers.map do |answer|
      ::Api::V1::AnswerSerializer.new(answer, scope: scope, root: false)
    end
  end

  def color
    @object.user.color
  end

end
