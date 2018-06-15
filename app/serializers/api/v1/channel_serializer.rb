class Api::V1::ChannelSerializer < ActiveModel::Serializer

  attributes :id,
             :name,
             :streamer_id,
             :slug,
             :stream_id,
             :is_live,
             :channel_type,
             :aws_channel_id,
             :aws_input_id,
             :streamer

  def streamer
    ::Api::V1::UserSerializer.new(@object.streamer, scope: scope, root: false)
  end

  def is_live
    @object&.streams&.first&.state == "live"
  end

  def stream_id
    @object&.streams&.first&.id
  end

end
