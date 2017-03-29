class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: session_params[:name])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:danger] = 'Invalid Credentials'
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
