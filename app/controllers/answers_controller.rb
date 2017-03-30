class AnswersController < ApplicationController
  def create
    question = Question.find(params[:answer][:question])
    answer = question.answers.new(answer_params)
    answer.user = current_user
    if answer.save
      flash[:success] = "You commented!"
      redirect_to question_path(question)
    else
      flash[:danger] = "Your comment was not successful."
      redirect_to question_path(question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
