class CreatePasswordTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :password_tokens do |t|
      t.string :token
      t.references :user

      t.timestamps
    end
  end
end
