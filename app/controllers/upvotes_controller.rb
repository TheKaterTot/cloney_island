class UpvotesController < ApplicationController
  def create
    @upvote = Upvote.new(upvote_params)
    @upvote.question = Question.find(params[:question_id])
    if @upvote.save
      redirect_to @upvote.question
    end
  end

  def destroy
  end

private
  def upvote_params
    params.require(:upvote).permit(:user_id)
  end
end
