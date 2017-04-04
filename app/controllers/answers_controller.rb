class AnswersController < ApplicationController
  before_filter :require_user

  def create
    @question = Question.find(params[:answer][:question])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @comment = @question.comments.new
    @upvote = Upvote.new
    @downvote = Downvote.new
    if @answer.save
      flash[:success] = "You answered the question!"
      redirect_to question_path(@question)
    else
      flash[:danger] = "Your comment was not successful."
      render "questions/show"
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def destroy
    Answer.destroy(params[:id])
    redirect_to request.referrer
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def require_user
    unless current_user
      question = Question.find(params[:answer][:question])
      flash[:danger] = "You must be logged in to do that."
      redirect_to question_path(question)
    end
  end
end
