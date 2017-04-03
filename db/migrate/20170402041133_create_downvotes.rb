class CreateDownvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :downvotes do |t|
      t.references :user, foreign_key: true
      t.integer :downvoted_id
      t.string :downvoted_type

      t.timestamps
    end
    add_index :downvotes, [:downvoted_id, :downvoted_type]
  end
end
