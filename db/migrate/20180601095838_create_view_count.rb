class CreateViewCount < ActiveRecord::Migration[5.1]
  def change
    create_table :view_counts do |t|
      t.references :stream, foreign_key: true
      t.integer :count, default: 0

      t.timestamps
    end

    remove_column :streams, :view_count
  end
end
