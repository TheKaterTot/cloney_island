class AddCreatorToDownvote < ActiveRecord::Migration[5.0]
  def change
    add_column :downvotes, :creator, :integer
  end
end
