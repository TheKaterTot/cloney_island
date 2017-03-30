class QuestionsController < ApplicationController

  def index
    @questions = Question.order_by_update
  end

  def new
    @question = current_user.questions.new
    @categories = Category.all
  end

  def create
    question = current_user.questions.new(question_params)
    if question.save
      flash[:success] = "Question successfully created!"
      redirect_to question_path(question)
    else
      flash[:danger] = "Failed to create question"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answers.new
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category_id)
  end


end
