class Likes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :stream

      t.timestamps
    end
  end
end
