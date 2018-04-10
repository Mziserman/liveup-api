class Api::V1::ChannelSerializer < ActiveModel::Serializer

  attributes :id,
             :message,
             :pseudo,
             :created_at

  def pseudo
    @object.user.pseudo
  end

end
