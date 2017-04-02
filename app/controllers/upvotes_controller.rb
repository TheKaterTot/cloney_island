class UpvotesController < ApplicationController
  def create
    if params[:upvote][:question_id]
      question = Question.find(params[:upvote][:question_id])
      upvote = question.upvotes.new(upvote_params)
    elsif params[:upvote][:answer_id]
      answer = Answer.find(params[:upvote][:answer_id])
      upvote = answer.upvotes.new(upvote_params)
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
    params.require(:upvote).permit(:user_id)
  end
end
