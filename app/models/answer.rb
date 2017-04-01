class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true

  def find_user
    user.name unless user.nil?
  end

end
