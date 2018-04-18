class CreateCommits < ActiveRecord::Migration[5.1]
  def change
    create_table :commits do |t|
      t.string :name
      t.string :path
      t.integer :version
      t.references :share_file

      t.timestamps
    end
  end
end
