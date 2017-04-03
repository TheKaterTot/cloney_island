class Downvote < ApplicationRecord
  belongs_to :user
  belongs_to :downvoted, :polymorphic => true
end
