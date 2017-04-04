class BestAnswersController < ApplicationController
  before_action :require_owner
  after_action only: [:create] do
    update_user_reputation(question.user_id)
  end

  def create
    if question.update_attributes(best_answer_params)
      flash[:success] = "You have a best answer!"
      redirect_to question_path(question)
    else
      flash[:danger] = "Unsuccessful. Please try again."
      redirect_to question_path(question)
    end
  end

  private

  def best_answer_params
    params.permit(:best_answer_id)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def require_owner
    unless question.user_id == current_user.id
      redirect_to question_path(question)
    end
  end
end
