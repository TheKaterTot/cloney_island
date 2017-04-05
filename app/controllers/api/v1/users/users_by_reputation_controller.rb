class Api::V1::Users::UsersByReputationController < ApplicationController
  def index
    render json: User.by_reputation
  end
end
