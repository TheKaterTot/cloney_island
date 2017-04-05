class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      session[:user_id] = @user.id
      flash[:success] = "For full user privileges, check your e-mail and validate your account."
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Account creation unsuccessful"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def update
    if current_user.update_attributes(user_update_params)
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Account update unsuccessful"
      render :edit
    end
  end

  private

  def user_update_params
    params.require(:user).permit(:email, :image, :phone)
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :image,
                                 :password,
                                 :password_confirmation,
                                 :phone)
  end
end
