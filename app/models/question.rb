class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  validates :title, :body, presence: true


  def self.order_by_update
    order(:updated_at)
  end

  def votes_value
    sum = 0
    votes.each do |vote|
      sum += (vote.value.to_i)
    end
    sum
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
