class SharedFile < ApplicationRecord

  belongs_to :stream
  has_many   :commits

  after_create :init_commit

  def init_commit
    commits.create(path: path, name: name + ' v0', version: 0, shared_file_id: id)
  end

end