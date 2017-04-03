class CommentsController < ApplicationController

  def create
    @presenter = Presenter.new
    @question = Question.find(comment_params[:question])
    @answer = Answer.populate_answer(comment_params)
    @comment = Comment.populate_comment(comment_params, @question, @answer)
    @comment.user = current_user
    @downvote = Downvote.new
    @upvote = Upvote.new
    if @comment.save
      flash[:success] = "Comment successfully created"
      redirect_to question_path(@question)
    else
      flash[:danger] = "Comment failed. Please re-enter your comment."
      render 'questions/show'
    end
  end

  def destroy
    Comment.destroy(params[:id])
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :answer, :question)
  end
end
