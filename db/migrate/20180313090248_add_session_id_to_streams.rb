class AddSessionIdToStreams < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :session_id, :string
  end
end
