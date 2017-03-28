class Question < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :answers
  has_many :comments, as: :commentable
end
