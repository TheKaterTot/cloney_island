class DownvotesController < ApplicationController
  after_action only: [:create] do
    update_user_reputation(params[:downvote][:user_id])
  end
  def create
    if params[:downvote][:question_id]
      question = Question.find(params[:downvote][:question_id])
      question.current_user_upvote_correction(downvote_params[:creator])
      downvote = question.downvotes.new(downvote_params)
    elsif params[:downvote][:answer_id]
      answer = Answer.find(params[:downvote][:answer_id])
      answer.current_user_upvote_correction(downvote_params[:creator])
      downvote = answer.downvotes.new(downvote_params)
    elsif params[:downvote][:comment_id]
      comment = Comment.find(params[:downvote][:comment_id])
      comment.current_user_upvote_correction(downvote_params[:creator])
      downvote = comment.downvotes.new(downvote_params)
    end
    if downvote.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
  end

private
  def downvote_params
    params.require(:downvote).permit(:user_id, :creator)
  end
end
