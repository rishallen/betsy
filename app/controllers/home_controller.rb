class HomeController < ApplicationController
  def index
    @username = params[:username] || "Adriana"
    # render :index, layout: nil
  end
end
