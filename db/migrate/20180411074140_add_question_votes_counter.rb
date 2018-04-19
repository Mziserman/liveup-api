class AddQuestionVotesCounter < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :question_votes_count, :integer, default: 0
    remove_column :questions, :score, :integer
  end
end
