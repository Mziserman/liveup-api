class BroadcastCommitWorker
  include Sidekiq::Worker

  def perform(commit_id)
    commit = ChatMessage.find(message_id)
    ActionCable
      .server
      .broadcast("stream_#{commit.shared_file.stream_id}_commit_channel",
                 id: commit.id,
                 version: commit.version,
                 path: commit.path,
                 name: commit.name,
                 created_at: commit.created_at)
  end
end
