class UserPermissionsController < ApplicationController

  def update
    user = User.find(params[:id])
    if !user.blocked_user?
      user.deactivate
      UserMailer.blocked_email(user).deliver_now
    else
      user.reactivate
      UserMailer.unblocked_email(user).deliver_now
    end
    redirect_to request.referrer
  end
end
