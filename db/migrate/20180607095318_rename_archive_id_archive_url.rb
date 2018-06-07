class RenameArchiveIdArchiveUrl < ActiveRecord::Migration[5.1]
  def change
    rename_column :streams, :archive_id, :archive_url
  end
end
