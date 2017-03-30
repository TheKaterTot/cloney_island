class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  validates :body, presence: true

  def find_user
    user.name unless user.name.nil?
  end
end
