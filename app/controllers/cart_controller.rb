class CartController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = Cart.all[:user_id]
  end

  def add
    @cart_add =  Cart.add(current_user_cart, params[:product_id])
  end

  # def new
  #   @cart = Cart.new
  # end
  #
  # def create
  #   @cart = Cart.new
  #   @cart.save
  # end

  def edit

  end

  def update

  end

  def show
    @cart_product = Product.find[:cart_id]
  end

  def current_user_cart
    "cart#{current_user.id}"
  end
end
