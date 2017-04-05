class AuthenticationController < ApplicationController

  def update
    @user = User.find(params[:id])
    UserRole.create(user_id:@user.id, role_id:1)
    flash.now[:success] = 'Your account has been authenticated!'
    render 'users/show'
  end
end
