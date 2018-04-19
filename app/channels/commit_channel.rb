class CommitChannel < ApplicationCable::Channel
  def subscribed
    channel = "stream_#{params[:stream_id]}_commit_channel"
    stream_from channel
  end

  def unsubscribed; end

  def create(options)
    Commit.create(
      path: options.fetch('path'),
      name: options.fetch('name'),
      shared_file_id: options.fetch('shared_file_id')
    )
  end
end
