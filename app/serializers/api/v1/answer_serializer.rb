class Api::V1::AnswerSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :score,
             :pseudo,
             :color,
             :user_id,
             :created_at

  def score
    @object.answer_votes_count
  end

  def pseudo
    @object.user.pseudo
  end

  def color
    @object.user.color
  end

end
