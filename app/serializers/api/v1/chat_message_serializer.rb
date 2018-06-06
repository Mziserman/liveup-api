class Api::V1::ChatMessageSerializer < ActiveModel::Serializer

  attributes :id,
             :content,
             :pseudo,
             :color,
             :user_id,
             :created_at

  def pseudo
    @object.user.pseudo
  end

  def color
    @object.user.color
  end

end
