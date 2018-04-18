class ShareFile < ApplicationRecord

  belongs_to :stream
  has_many   :commits

  after_create :init_commit

  def init_commit
    commits.create(path: path, name: name + ' v0', version: 0, share_file_id: id)
  end

end