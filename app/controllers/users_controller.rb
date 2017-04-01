class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserRole.create(user_id:@user.id, role_id:1)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
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
