class HomeController < ApplicationController

  def show
    @presenter = Presenter.new
  end
end
