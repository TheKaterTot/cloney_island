class User < ApplicationRecord
  has_many :answers
  has_many :questions
  has_many :comments, as: :commentable
  has_many :user_roles
  has_many :roles, through: :user_roles
end
