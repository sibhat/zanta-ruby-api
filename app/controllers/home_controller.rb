class HomeController < ApplicationController
  def index
    render json: { message: "working" }
  end
end