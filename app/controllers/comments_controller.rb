class CommentsController < ApplicationController

  def create
    comment = Question.find(params[:comment][:question]).comments.new(comment_params)
    comment.user = current_user
    if comment.save
      flash[:success] = "Comment successfully created"
      redirect_to request.referer
    else
      flash[:danger] = "Comment failed. Please enter body and try again."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
