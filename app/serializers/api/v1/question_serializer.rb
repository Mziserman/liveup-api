class Api::V1::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :score,
             :pseudo,
             :user_id,
             :created_at

  def score
    @object.question_votes_count
  end

  def pseudo
    @object.user.pseudo
  end

end
