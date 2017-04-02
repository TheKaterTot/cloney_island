class Downvote < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :user, uniqueness: {scope: :question}
  validates :question, uniqueness: {scope: :user}
end
