class CreateQuestionVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :question_votes do |t|
      t.references :user
      t.references :question

      t.timestamps
    end
  end
end
