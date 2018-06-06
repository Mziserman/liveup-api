class AddCategoryToStream < ActiveRecord::Migration[5.1]
  def change
    remove_column :streams, :category
  	add_column :streams, :category, :string, null: true
  end
end
