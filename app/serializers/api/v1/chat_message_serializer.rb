class Api::V1::ChatMessageSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :pseudo,
             :user_id,
             :created_at

  def pseudo
    @object.user.pseudo
  end

end
