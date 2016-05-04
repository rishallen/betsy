class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order

  def current_order
    if !session[:order_id].nil? && Order.find_by(order_id: session[:order_id]).status == "pending"
      Order.find(session[:order_id])
    else
      Order.new(status: "pending")
    end
  end
end
