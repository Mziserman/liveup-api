class ChangeFollowUserToStreamer < ActiveRecord::Migration[5.1]
  def change
    remove_column :follows, :stream_id
    remove_column :follows, :user_id
    add_reference :follows, :streamer
    add_reference :follows, :follower
  end
end
