class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :score
      t.references :user
      t.references :stream
    end
  end
end
