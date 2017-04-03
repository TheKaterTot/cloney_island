class UpvotesController < ApplicationController
  def create
    if params[:upvote][:question_id]
      question = Question.find(params[:upvote][:question_id])
      question.current_user_downvote_correction(upvote_params[:creator])
      upvote = question.upvotes.new(upvote_params)
    elsif params[:upvote][:answer_id]
      answer = Answer.find(params[:upvote][:answer_id])
      answer.current_user_downvote_correction(upvote_params[:creator])
      upvote = answer.upvotes.new(upvote_params)
    elsif params[:upvote][:comment_id]
      comment = Comment.find(params[:upvote][:comment_id])
      comment.current_user_downvote_correction(upvote_params[:creator])
      upvote = comment.upvotes.new(upvote_params)
    end
    if upvote.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
  end

private
  def upvote_params
    params.require(:upvote).permit(:user_id, :creator)
  end
end
