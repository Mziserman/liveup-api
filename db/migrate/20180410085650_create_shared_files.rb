class CreateSharedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :shared_files do |t|
      t.string  :name
      t.string  :path
      t.references :stream

      t.timestamps
    end
  end
end