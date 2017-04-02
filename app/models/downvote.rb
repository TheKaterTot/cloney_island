class Downvote < ApplicationRecord
  belongs_to :user
  belongs_to :downvoted, :polymorphic => true
  # validates :user, uniqueness: {scope: :question}
  # validates :question, uniqueness: {scope: :user}
end
