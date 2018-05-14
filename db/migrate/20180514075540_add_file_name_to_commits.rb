class AddFileNameToCommits < ActiveRecord::Migration[5.1]
  def change
  	add_column :commits, :file_name, :string
  end
end
