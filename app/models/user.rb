class User < ApplicationRecord
  has_secure_password
  has_many :answers
  has_many :questions
  has_many :comments
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :name, :email, :phone, presence: true

  def comments_to_recent_activity
    Comment.comments_to_user_activity[0..4]
  end
end
