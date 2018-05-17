class ChatMessage < ApplicationRecord
  after_create_commit do
    BroadcastChatMessageWorker.perform_async(id)
  end

  default_scope { order(created_at: :asc) }

  belongs_to :stream
  belongs_to :user
end
