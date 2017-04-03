class Downvote < ApplicationRecord
  belongs_to :user
  belongs_to :downvoted, :polymorphic => true
  validates :creator, presence: true
  
  # validates :user, uniqueness: {scope: :question}
  # validates :question, uniqueness: {scope: :user}

  # validates_uniqueness_of :user, scope: :question
end
