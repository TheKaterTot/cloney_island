class QuestionsController < ActionController::Base

  def index
    @questions = Question.order_by_update
  end



end
