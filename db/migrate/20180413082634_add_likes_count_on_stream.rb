class AddLikesCountOnStream < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :likes_count, :integer, default: 0
  end
end
