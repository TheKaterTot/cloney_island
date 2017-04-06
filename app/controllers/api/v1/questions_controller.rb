class Api::V1::QuestionsController < Api::V1::BaseController

  def create
    Question.create(question_params)
  end

private

  def question_params
    params.permit(:title, :body, :category_id, :user_id)
  end
end
