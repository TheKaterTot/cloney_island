class PasswordsController < ApplicationController
  before_action :require_valid_token, only: [:update]

  def edit
    send_token
  end

  def update
    current_user.update_attributes(password_params)
    redirect_to user_path(current_user)
  end

  private

  def require_valid_token
    unless password_token
      flash.now[:danger] = "Invalid Token"
      render :edit
    end
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end

  def password_token
    current_user
      .password_tokens
      .find_by(token: params[:token])
  end

  def send_token
    TokenSender.new(current_user).execute
  end
end
