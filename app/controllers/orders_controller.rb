class OrdersController < ApplicationController
  def index
    # @orders = Order.find_by(session_id: session[:session_id])
    @mechant_orders = Order.find_by(user_id: session[:user_id])
    render :index
  end

  def show
    @order = Order.find(:id) #requires order id be passed in!
    render :show
  end
 #NEW MAY NOT BE NEEDED - CREATE/POST ONLY
  def new #if order(user_id) exists "pending", show else create new
    @order = Order.new #MAY NEED SESSION ID INPUT
    render :products #Assuming we've created new order for guest/created new account and are now logged in
  end

  def create
    @order = Order.new(create_order_params[:order])
    if @order.save
      # @orders = Order.find(user_id: session[:user_id])
      redirect_to user_orders # AFTER CART IS created, where do we go?
    else
      render :new
    end
  end

  def edit #Editing orders should only be "PENDING" orders, should be in cart
    @order = current_order
    @order_items = @order.order_items
      render user_cart_path
  end

  def update
    @order = current_order
    @order_items = @order.order_items.update(params[:order_items]) #fix this, I don't know what I'm doing
    render user_cart_path
  end


  def destroy # A "clear cart" function?
    @order = current_order.order_items.destroy #may not be right

  end

  private
  def create_order_params
    params.permit(order: [:session_id, :user_id, :status, :mailing_address, :cc_digits, :expiration]) #double check attributes
  end
end
