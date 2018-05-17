class BroadcastChatMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = ChatMessage.find(message_id)
    ActionCable
      .server
      .broadcast("stream_#{message.stream_id}_chat_channel",
                 id: message.id,
                 user_id: message.user_id,
                 created_at: message.created_at,
                 content: message.content,
                 pseudo: message.user.pseudo)
  end
end
