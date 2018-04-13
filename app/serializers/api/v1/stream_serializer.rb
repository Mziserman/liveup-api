class Api::V1::StreamSerializer < ActiveModel::Serializer

  attributes :id,
             :channel_id,
             :session_id,
             :token,
             :likes

  def likes
    @object.likes_count
  end

end
