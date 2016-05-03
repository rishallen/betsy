class CartController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @cart = Cart.all
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new
    @cart.save
  end

  def edit

  end

  def update

  end

  def show

  end

  def current_user_cart
    "cart#{current_user.id}"
  end
end
