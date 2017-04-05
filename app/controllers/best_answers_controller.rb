class BestAnswersController < ApplicationController
  before_action :require_owner
  after_action only: [:create] do
    update_user_reputation(question.user_id)
  end

  def create
    question.update_attributes(best_answer_params)
    redirect_to question_path(question)
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
