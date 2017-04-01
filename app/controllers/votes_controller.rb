class VotesController < ApplicationController

  def create
    @question = Question.find(params["question_id"])
    @vote = @question.votes.new(vote_params)
    if @vote.save
      flash[:success] = "Thanks for the feedback!"
      redirect_to question_path(@question)
    else
      flash[:danger] = "You've already voted!"
    end
  end

  private

  def vote_params
    params.permit(:value, :user_id)
  end
end