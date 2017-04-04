class AddBestAnswerToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :best_answer_id, :integer
  end
end
