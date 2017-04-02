class CreateUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :upvotes do |t|
      t.references :user, foreign_key: true
      t.integer :upvoted_id
      t.string :upvoted_type

      t.timestamps
    end
    add_index :upvotes, [:upvoted_id, :upvoted_type]
  end
end
