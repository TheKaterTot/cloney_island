class VotesController < ApplicationController

  def create
    @question = Question.find(params["question_id"])
    @question.votes.create(vote_params)
  end

  private

  def vote_params
    params.permit(:value)
  end
end