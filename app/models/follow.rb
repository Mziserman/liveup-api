class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: :follower_id
  belongs_to :channel

  after_create_commit :broadcast_create
  def broadcast_create
    stream = channel.streams.first
    ActionCable
      .server
      .broadcast("stream_#{stream.id}_streamer_channel",
        event: "follow",
        pseudo: follower.pseudo,
        color: follower.color)
  end

  after_destroy_commit :broadcast_destroy
  def broadcast_destroy
    stream = channel.streams.first
    ActionCable
      .server
      .broadcast("stream_#{stream.id}_streamer_channel",
        event: "unfollow",
        pseudo: follower.pseudo,
        color: follower.color)
  end
end
