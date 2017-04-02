class UserPermissionsController < ApplicationController

  def update
    user = User.find(params[:id])
    user.user_roles.destroy_all
    user.save
    user.roles.create(name: 'blocked_user')
    user.save
    redirect_to request.referrer
  end
end
