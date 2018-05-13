class AddDescriptionAndTitleToStreams < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :title, :string
    add_column :streams, :description, :string
  end
end
