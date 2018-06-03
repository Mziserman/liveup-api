class ViewCountChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_view_count_channel"
    stream_from channel

    stream = Stream.find(params[:stream_id])
    stream.view_counts.create(count: stream.view_count + 1, total_count: stream.total_view_count + 1)
  end

  def unsubscribed
    stream = Stream.find(params[:stream_id])
    stream.view_counts.create(count: stream.view_count - 1)
  end
end
