class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :upvoted, :polymorphic => true

  # validates :user, uniqueness: {scope: :question}
  # validates :question_id, uniqueness: {:scope => :upvoted_id}

end
