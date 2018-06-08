class ChatChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_chat_channel"
    stream_from channel
  end

  def unsubscribed; end

  def create(options)
    ChatMessage.create(
      content: options.fetch('content'),
      stream_id: params[:stream_id],
      user: current_user,
      avatar: avatar.url
    )
  end
end
