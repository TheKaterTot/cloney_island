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
end
