class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_many :comments, as: :commentable


  def self.order_by_update
    order(:updated_at)
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
end
