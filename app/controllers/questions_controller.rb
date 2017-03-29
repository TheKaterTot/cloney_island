class QuestionsController < ApplicationController

  def index
    @questions = Question.order_by_update
  end

  def show
    @question = Question.find(params[:id])
  end
end
