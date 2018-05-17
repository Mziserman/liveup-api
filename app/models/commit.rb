class Commit < ApplicationRecord

  after_create_commit do
    BroadcastCommitWorker.perform_async(id)
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
