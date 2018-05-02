class CommitChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_commit_channel"
    stream_from channel
  end

  def unsubscribed; end
  
end
