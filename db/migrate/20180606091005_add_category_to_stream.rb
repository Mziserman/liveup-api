class AddCategoryToStream < ActiveRecord::Migration[5.1]
  def change
  	add_column :streams, :category, :string, null: true
  end
end
