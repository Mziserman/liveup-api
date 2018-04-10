class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :score, default: 0
      t.references :user
      t.references :stream

      t.timestamps
    end
  end
end
