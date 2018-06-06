class AddViewCountRediffusion < ActiveRecord::Migration[5.1]
  def change
    add_column :streams, :rediffusion_view_count, :integer, default: 0
  end
end
