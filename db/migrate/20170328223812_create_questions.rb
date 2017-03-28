class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
