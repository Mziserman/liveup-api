class AddLiveToStreams < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :live, :boolean
  end
end
