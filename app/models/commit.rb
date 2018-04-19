class Commit < ApplicationRecord

  belongs_to :shared_file

  before_create version_and_shit_nigga

  def version_and_shit_nigga
    version = file.commit.last.version + 1
  end

end