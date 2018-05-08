class ChatMessageCreationEventBroadcastWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = ChatMessage.find(message_id)
    ActionCable
      .server
      .broadcast('chat_channel',
                 id: message.id,
                 created_at: message.created_at.strftime('%H:%M'),
                 content: message.content)
  end
end
