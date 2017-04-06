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

  validates :name, :email, :phone, :reputation, presence: true

  before_create -> { self.auth_token = SecureRandom.hex }

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

  def upvote_count
    upvotes.count
  end

  def downvote_count
    downvotes.count
  end

  def reputation_count
    upvote_count - downvote_count + best_answer_count
  end

  def best_answer_count
    answers.joins(:best_question).count
  end

  def self.by_reputation
    order(:reputation).reverse_order[0..9]
  end

  def self.need_to_block
    joins(:roles).where("roles.name != 'blocked_user'")
    .where("users.reputation <= -10")
  end

  def self.banned
    find_by_sql([
      "select u.id, u.name, u.email, u.reputation, r.name AS status
      from users u
      inner join user_roles ur on u.id = ur.user_id
      inner join roles r on ur.role_id = r.id
      where r.name = 'blocked_user';"
      ])
  end
end
