class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: :follower_id
  belongs_to :channel

  after_commit :broadcast
  def broadcast
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_streamer_channel",
        pseudo: follower.pseudo,
        color: follower.color)
  end

end
