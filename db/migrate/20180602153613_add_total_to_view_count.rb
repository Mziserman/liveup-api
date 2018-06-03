class AddTotalToViewCount < ActiveRecord::Migration[5.1]
  def change
    add_column :view_counts, :total_count, :integer, default: 0
  end
end
