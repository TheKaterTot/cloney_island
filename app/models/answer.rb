class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
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

  def current_user_upvote_correction(answer, creator_id)
    if answer.upvotes.where(creator: creator_id).exists?
      answer.upvotes.where(creator:creator_id).destroy_all
    end
  end

  def current_user_downvote_correction(answer, creator_id)
    if answer.downvotes.where(creator: creator_id).exists?
      answer.downvotes.where(creator:creator_id).destroy_all
    end
  end

  def answer_reputation
    upvotes.count - downvotes.count
  end
end
