class AddCreatorToUpvote < ActiveRecord::Migration[5.0]
  def change
    add_column :upvotes, :creator, :integer
  end
end
