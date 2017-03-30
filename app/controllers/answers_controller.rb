class AnswersController < ApplicationController
  def create

  end

  private

  def answer_params
    require(:answer).permit(:body)
  end
end
