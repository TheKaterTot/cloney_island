class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :body, presence: true
  has_many :upvotes, as: :upvoted, dependent: :destroy
  has_many :downvotes, as: :downvoted, dependent: :destroy


  def self.order_by_update
    order(:updated_at).reverse_order
  end

  def find_user
    user.name
  end

  def find_category
    category.name
  end

  def answer_count
    answers.count
  end

  def current_user_upvote_correction(question, creator_id)
    if question.upvotes.where(creator: creator_id).exists?
      question.upvotes.where(creator:creator_id).destroy_all
    end
  end

  def current_user_downvote_correction(question, creator_id)
    if question.downvotes.where(creator: creator_id).exists?
      question.downvotes.where(creator:creator_id).destroy_all
    end
  end

  def question_reputation
    upvotes.count - downvotes.count
  end
end
