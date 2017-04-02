class User < ApplicationRecord
  has_secure_password
  has_many :answers
  has_many :comments
  has_many :password_tokens
  has_many :questions
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :upvotes, dependent: :destroy
  has_many :downvotes, dependent: :destroy

  validates :name, :email, :phone, presence: true

  def comments_to_recent_activity
    Comment.comments_to_user_activity(self.id)[0..4]
  end

  def recent_questions
    questions.last(5).reverse!
  end

  def recent_answers
    answers.last(5).reverse!
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def blocked_user?
    roles.exists?(name: "blocked_user")
  end

  def deactivate
    user_roles.destroy_all
    user_roles.create(role: Role.find_by(name: "blocked_user"))
  end

  def reactivate
    user_roles.destroy_all
    user_roles.create(role: Role.find_by(name: "registered_user"))
  end

  def upvote_count(user)
    user.upvotes.count
  end

  def downvote_count(user)
    user.downvotes.count
  end

  def reputation_count(user)
    (upvote_count(user)-downvote_count(user))
  end
end
