class AddViewCountToStream < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :view_count, :integer, default: 0
  end
end
