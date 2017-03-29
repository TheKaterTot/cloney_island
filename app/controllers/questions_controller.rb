class QuestionsController < ApplicationController

  def index
    @questions = Question.order_by_update
  end



end
