class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  validates :body, presence: true

  def source_question
    if commentable_type == "Question"
      commentable
    else
      commentable.question
    end
  end

  def self.comments_to_user_activity(user_id)
    joins("LEFT OUTER JOIN questions ON comments.commentable_id = questions.id AND comments.commentable_type = 'Question'")
    .joins("LEFT OUTER JOIN answers ON comments.commentable_id = answers.id AND comments.commentable_type = 'Answer'")
    .where("questions.user_id = #{user_id} OR answers.user_id = #{user_id}")
    .order(:updated_at)
  end

  def find_user
    return user.name unless user.nil?
  end

  def update_date
    return updated_at.strftime("%D at %r") unless created_at.nil?
  end

  def self.populate_comment(comment_params, question, answer)
    if comment_params[:answer]
      answer.comments.build(body: comment_params[:body])
    else
      question.comments.build(body: comment_params[:body])
    end
  end

  def self.check_comments
    if count >= 1 && first.body != nil
      true
    else
      false
    end
  end
end
