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

  def find_user_object
    user
  end

  def find_category
    category.name
  end

  def answer_count
    answers.count
  end

  def current_user_upvote_correction(creator_id)
    if upvotes.where(creator: creator_id).exists?
      upvotes.where(creator:creator_id).destroy_all
    end
  end

  def current_user_downvote_correction(creator_id)
    if downvotes.where(creator: creator_id).exists?
      downvotes.where(creator:creator_id).destroy_all
    end
  end

  def self.show_all_questions(category)
    if category
      where(category: Category.find(category))
    else
      order_by_update
    end
  end

  def question_upvotes
    upvotes.count
  end

  def question_downvotes
    downvotes.count
  end

  def net_votes
    question_upvotes - question_downvotes
  end
end
