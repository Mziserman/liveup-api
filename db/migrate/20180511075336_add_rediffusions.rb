class AddRediffusions < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :archive_id, :string
  end
end
