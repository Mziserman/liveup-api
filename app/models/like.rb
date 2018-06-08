class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :stream }

  belongs_to :stream, counter_cache: true
  belongs_to :user

  after_create_commit :broadcast_create
  def broadcast_create
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_streamer_channel",
        event: "like",
        avatar: user.avatar.url,
        pseudo: user.pseudo,
        color: user.color)
  end

  after_destroy_commit :broadcast_destroy
  def broadcast_destroy
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_streamer_channel",
        event: "unlike",
        pseudo: user.pseudo,
        avatar: user.avatar.url,
        color: user.color)
  end
end
