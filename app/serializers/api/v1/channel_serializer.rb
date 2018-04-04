class Api::V1::ChannelSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :streamer_id,
             :slug,
             :stream_id,
             :is_live

  def is_live
    true
  end

  def stream_id
    @object&.streams&.last&.id
  end

end
