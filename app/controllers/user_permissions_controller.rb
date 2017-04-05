class UserPermissionsController < ApplicationController

  def update
    user = User.find(params[:id])
    if !user.blocked_user?
      user.deactivate
    else
      user.reactivate
    end
    redirect_to request.referrer
  end
end
