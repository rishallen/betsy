class HomeController < ApplicationController
  def index
    @username = params[:username] || "Adriana"
  end
end
