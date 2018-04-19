class Api::V1::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :score,
             :pseudo,
             :answers,
             :user_id,
             :created_at

  def score
    @object.question_votes_count
  end

  def pseudo
    @object.user.pseudo
  end

  def answers
    @object.answers.map do |answer|
      AnswerSerializer.new(answer, scope: scope, root: false)
    end
  end

end
