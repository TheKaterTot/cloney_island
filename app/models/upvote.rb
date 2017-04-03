class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :upvoted, :polymorphic => true
  validates :creator, presence: true
end
