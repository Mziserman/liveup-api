class Api::V1::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :score,
             :pseudo,
             :user_id,
             :created_at

  def pseudo
    @object.user.pseudo
  end

end
