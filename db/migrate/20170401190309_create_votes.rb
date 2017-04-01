class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :user, foreign_key: true
      t.integer :votable_id
      t.string :votable_type

      t.timestamps
    end
    add_index :votes, [:votable_id, :votable_type]
  end
end
