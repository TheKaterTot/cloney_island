class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
