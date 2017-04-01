class QuestionsController < ApplicationController

  def index
    @questions = Question.order_by_update.page(params[:page]).per(25)
  end

  def new
    if current_user
      @question = current_user.questions.new
      @categories = Category.all
    else
      redirect_to login_path
    end
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:success] = "Question successfully created!"
      redirect_to question_path(@question)
    else
      @categories = Category.all
      flash[:danger] = "Failed to create question"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answers.new
  end

  def edit
    @question = Question.find(params[:id])
    @categories = Category.all
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "Your question was edited successfully!"
      redirect_to question_path(@question)
    else
      flash[:danger] = "Failed to edit question. Please try again."
      redirect_to edit_question_path(@question)
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category_id)
  end

end
