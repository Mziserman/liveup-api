class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :question
      t.text :content
      t.integer :answer_votes_count, default: 0
      t.references :user
      t.references :stream

      t.timestamps
    end

    create_table :answer_votes do |t|
      t.references :user
      t.references :answer

      t.timestamps
    end
  end
end
