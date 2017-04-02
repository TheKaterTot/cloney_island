class DownvotesController < ApplicationController
  def create
    if params[:downvote][:question_id]
      question = Question.find(params[:downvote][:question_id])
      downvote = question.downvotes.new(downvote_params)
    elsif params[:downvote][:answer_id]
      answer = Answer.find(params[:downvote][:answer_id])
      downvote = answer.downvotes.new(downvote_params)
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
    params.require(:downvote).permit(:user_id)
  end
end
