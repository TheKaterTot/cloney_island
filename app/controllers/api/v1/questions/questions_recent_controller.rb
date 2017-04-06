class Api::V1::Questions::QuestionsRecentController < ApplicationController
  def index
    render json: Question.recent_questions, each_serializer: QuestionRecentSerializer
  end
end