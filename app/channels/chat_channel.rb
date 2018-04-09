class ChatChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_channel"
    stream_from channel
  end

  def unsubscribed; end

  def create(options)
    cm = ChatMessage.create(
      content: options.fetch('content'),
      stream_id: params[:stream_id],
      user: @current_user
    )
    puts cm.errors.inspect
  end
end
