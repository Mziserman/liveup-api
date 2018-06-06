class ViewCount < ApplicationRecord

  belongs_to :stream

  after_create :broadcast

  def broadcast
    ActionCable
      .server
      .broadcast("stream_#{stream_id}_view_count_channel",
                 created_at: created_at,
                 count: count,
                 total_count: total_count)
  end
end
