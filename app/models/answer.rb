class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :best_question, class_name: "Question", inverse_of: :best_answer, foreign_key: :best_answer_id
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :upvotes, as: :upvoted, dependent: :destroy
  has_many :downvotes, as: :downvoted, dependent: :destroy
  validates :body, presence: true

  def find_user
    user.name unless user.nil?
  end

  def self.populate_answer(comment_params)
    if comment_params[:answer]
      Answer.find(comment_params[:answer])
    else
      Answer.new(question_id: comment_params[:question])
    end
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

  def answer_reputation
    upvotes.count - downvotes.count
  end

  def find_user_id
    user.id
  end
end
