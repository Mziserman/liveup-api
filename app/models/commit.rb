class Commit < ApplicationRecord

  after_create_commit do
    ActionCable
      .server
      .broadcast("stream_#{shared_file.stream_id}_commit_channel",
                 version: version,
                 path: path,
                 name: name,
                 created_at: created_at)
  end

  belongs_to :shared_file

  before_create :create_version

  def create_version
    if shared_file.commits.last
      self.version = shared_file.commits.last.version + 1
    else
      self.version = 0
    end
  end

end
