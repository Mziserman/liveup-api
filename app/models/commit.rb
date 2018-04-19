class Commit < ApplicationRecord

  belongs_to :shared_file

  before_create create_version

  def create_version
    version = file.commit.last.version + 1
  end

end