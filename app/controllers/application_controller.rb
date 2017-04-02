class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :current_permission,
                :current_admin?,
                :current_users_question?

  before_action :authorize!

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    unless authorized?
      flash[:danger] = "You are not authorized to do that. Please log in or create an account."
      redirect_to root_path
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_users_question?(question)
    current_user && current_user.id == question.user_id
  end

end
