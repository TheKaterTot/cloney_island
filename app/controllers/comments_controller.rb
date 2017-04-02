class CommentsController < ApplicationController

  def create
    @question = Question.find(params[:comment][:question])
    @comment = @question.comments.new(comment_params)
    @comment.user = current_user
    @answer = @question.answers.new
    if @comment.save
      flash[:success] = "Comment successfully created"
      redirect_to request.referer
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
    params.require(:comment).permit(:body)
  end
end
