class ChatMessage < ApplicationRecord
  after_create_commit do ChatMessageCreationEventBroadcastWorker.perform_later(self)
end
