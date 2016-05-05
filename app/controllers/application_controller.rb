class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @username = params[:username] || "Adriana"
  end

  helper_method :current_user

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_order

  def current_order
    # user_id = session[:user_id] ||= nil

    if session[:order_id].nil? #&& Order.find_by(order_id: session[:order_id]).status == "pending"
       order = Order.create(status: "pending")
       session[:order_id] = order.id

    #   @current_order = Order.find(session[:order_id])
    #   @current_order = Order.create(status: "pending") #user_id: user_id)
    #   session[:order_id] = @current_order.id
    end
    @current_order ||= Order.find_or_create_by(id: session[:order_id])

  end
  # @current_order
end

###
