require_relative '../../lib/shipping_wrapper.rb'
require 'pry'

class OrdersController < ApplicationController
  def index
    # @orders = Order.find_by(session_id: session[:session_id])
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @products = Product.where(user_id: session[:user_id])
      @order_items = OrderItem.where(product_id: @user.products)
      if !@order_items.empty?
        @order_items_paid = []
        @order_items_complete = []
        @order_items.each do |item|
          (@order_items_paid << item) if item.order.status == "paid"
          (@order_items_complete << item) if item.order.status == "complete"
        end
      #NEEDS ADDITIONAL CLAUSES TO IDENTIFY ORDER FROM ORDER ITEMS
      end
    else
      render :new_session_path
    end
    # @order_items = @merchant_orders.order_items
    render :index
  end

  def show
    @order = Order.find(params[:id]) #requires order id be passed in!
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

  def cart
    @order_items = current_order.order_items
  end

  def checkout
    @order = current_order
    render :checkout
  end

  def add_to_cart
    current_order.order_items << OrderItem.create(order_id: session[:order_id], product_id: params[:product_id], quantity: 1)
    redirect_to cart_path
  end

  def destroy # A "clear cart" function?
    @order = current_order.order_items.destroy

  end

  def get_rates

    # orders is going to be a collection of order items

    ## for each order there will be a collection of order items
    ## loop through the order item and save the NEEDED INFO as a collection of an array
      ##INFO NEEDED
      ## order item contains a product_id where you can retrive the product WEIGHT
      ## find each user for the product and get the MERCHANT ADDRESS
      ## QUANTITY will come from order_item

    ## API will get origins = [{ weigth: "weight", quantity: "blah", country: "blah", city: "blah", state: "blah", zip: "blah"}, { weigth: "weight", quantity: "blah", country: "blah", city: "blah", state: "blah", zip: "blah"}]

    ### Already have the below info
    ## API will get destination = { country: "blah", city: "blah", state: "blah", zip: "blah"}
    ## API will get order = {order: order_id}
    # holds the collection of origin, destination, and weight



    # this is going to filter out information
    # this method will be the one that talks to the api
    order = Order.find(rates_params[:order][:order_id])
    destination = (rates_params[:destination])

    # order.products.each do |product|
    #     user = product.user
    # # order.order_items.product.group_by(&:user).each do |user, order_items|

      order_route_array =[]
      order.order_items.each do |order_item|
        total_weight = order_item.product.weight * order_item.quantity
        user = order_item.product.user
      # total_weight = weights.inject(:+)
    # order.order_items.each do |item|
    #   user = item.product.user
      origin = {
        country: user.country,
        state: user.state,
        city: user.city,
        zip: user.zip,
      }

    order_route_array << { :origin => origin, :weight => total_weight, :order_item => order_item}
    ## after finding the us
end


    # calls the shippingwrapper
    # get rates knows about params because we passed it in

    @rates = ShippingWrapper.get_rates(order, destination, order_route_array)

    redirect_to cart_checkout_path
  end

  def get_rates_response
    @return_rates = params([:id])
    @user = current_user.uid
      rates = ShippingWrapper.response_rates(@user, @return_rates)
      redirect_to root_path
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
      item.update(checkout_price: Product.find_by(id: product_id).price)
    end
    @order_placed = current_order
    order_info = create_order_params[:order]
    order_info[:cc_digits] = order_info[:cc_digits][-4..-1].to_i
    order_info[:status] = "paid"
    @order_placed.update(order_info)
    if session[:user_id]
      @order = Order.create(status: "pending", user_id: session[:user_id])
      session[:order_id] = @order.id
    else
      @order = Order.create(status: "pending")
      session[:order_id] = @order.id
    end
    render :order_review
  end

  def update
    #pass in an order_id
    order = Order.find(params[:id])
    order.update(status: "complete")
    redirect_to user_orders_path
  end

  private
  def create_order_params
    params.permit(order: [:user_id, :status, :mailing_address, :cc_digits, :expiration]) #double check attributes
  end

  def rates_params
    params.permit(destination: [ :city, :state, :country, :"zip"], order: :order_id)
  end
end
