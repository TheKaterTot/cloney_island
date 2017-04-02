class UserPermissionsController < ApplicationController

  def update
    user = User.find(params[:id])
    user.deactivate
    redirect_to request.referrer
  end
end
