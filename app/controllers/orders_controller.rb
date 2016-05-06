class OrdersController < ApplicationController
  def index
    # @orders = Order.find_by(session_id: session[:session_id])
    @mechant_orders = Order.find_by(user_id: session[:user_id])
    # @order_items = @merchant_orders.order_items
    render :index
  end

  def show
    @order = Order.find(:id) #requires order id be passed in!
    @order_items = @order.order_items
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

  # def edit #Editing orders should only be "PENDING" orders, should be in cart
  #   @order = current_order
  #   @order_items = @order.order_items
  #     render user_cart_path
  # end
  #
  # def update
  #   @order = current_order
  #   @order_items = @order.order_items.update(params[:order_items]) #fix this, I don't know what I'm doing
  #   render user_cart_path
  # end

  def cart
    @order_items = current_order.order_items
  end

  def checkout
    @order = current_order
    render :checkout
  end

  def add_to_cart
    ## REDUNDANT ???
    #if product_id already in current_order, just add + 1, else
    #add one item by :product_id param to the current_order
    if !current_order.order_items.where(product_id: params[:product_id]).empty?
      item = current_order.order_items.find_by(product_id: params[:product_id])
      item.quantity = item.quantity + 1
    else
      current_order.order_items << OrderItem.create(order_id: session[:order_id], product_id: params[:product_id], quantity: 1)
    end
    #  binding.pry
    redirect_to cart_path
  end

  def destroy # A "clear cart" function?
    @order = current_order.order_items.destroy #may not be right

  end

  def order_placed #call when "confirm order/pay" button is used, params should include status update
    @items = current_order.order_items
    @items.each do |item|
      product_id = item.product_id
      current_stock = Product.find_by(id: product_id).stock
      if current_stock-item.quantity >= 0
        Product.find_by(id: product_id).update(stock: (current_stock-item.quantity))
      else
        item.update(quantity: current_stock)
        Product.find_by(id: product_id).update(stock: 0)
      end
    end
    @order_placed = current_order
    @order_placed.update(create_order_params[:order])
    if session[:user_id]
      @order = Order.create(status: "pending", user_id: session[:user_id])
    else
      @order = Order.create(status: "pending")
    end
    render :order_review
  end

  private
  def create_order_params
    params.permit(order: [:user_id, :status, :mailing_address, :cc_digits, :expiration]) #double check attributes
  end
end
