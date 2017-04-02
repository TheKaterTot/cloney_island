class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true

  def find_user
    user.name unless user.nil?
  end

  def self.populate_answer(comment_params)
    if comment_params.has_key?(:answer)
      Answer.find(comment_params[:answer])
    else
      Answer.new(question_id: comment_params[:question])
    end
  end
end
