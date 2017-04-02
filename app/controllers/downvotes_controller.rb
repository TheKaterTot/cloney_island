class DownvotesController < ApplicationController
  def create
    downvote = Downvote.new(downvote_params)
    downvote.question = Question.find(params[:question_id])
    if downvote.save
      redirect to downvote.question
    end
  end

  def destroy
  end

private
  def downvote_params
    params.require(:downvote).permit(:user_id)
  end
end
