class Commit < ApplicationRecord

  after_create_commit do
    ActionCable
      .server
      .broadcast("stream_#{file.stream_id}_commit_channel",
                 version: version,
                 path: path,
                 name: name,
                 created_at: created_at)
  end

  belongs_to :shared_file

  before_create :create_version

  def create_version
    version = file.commit.last.version + 1
  end

end
