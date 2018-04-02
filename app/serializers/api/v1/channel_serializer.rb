class Api::V1::ChannelSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :streamer_id,
             :slug,
             :stream_id


  def stream_id
    @object&.streams&.last&.id
  end

end
