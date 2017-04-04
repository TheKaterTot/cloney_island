class Api::V1::Users::UsersBannedController < ApplicationController

  def index
    render json: User.banned, each_serializer: UserBannedSerializer
  end
end