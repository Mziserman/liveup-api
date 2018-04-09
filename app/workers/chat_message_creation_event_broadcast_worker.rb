class ChatMessageCreationEventBroadcastWorker
  include Sidekiq::Worker

  def perform(message)
    ActionCable
      .server
      .broadcast('chat_channel',
                 id: message.id,
                 created_at: message.created_at.strftime('%H:%M'),
                 content: message.content)
  end
end
