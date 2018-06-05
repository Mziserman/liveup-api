class AddThumbnailToStream < ActiveRecord::Migration[5.1]
  def change
		add_column :streams, :thumbnail, :string, null: true
  end
end
