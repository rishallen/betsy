class ProductsController < ApplicationController

  def index
  @sellers = show_sellers
  @categories =  show_category
    if params[:category]
      by_category
    elsif params[:user_id]
      by_seller
    else
      @products = Product.order('LOWER (category)')
    end
    render :index
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.find_by(product_id: params[:id]) #returns nil if not found 
    render :show
  end

  def new
    @product = Product.new
    @user = User.find_by(id: params[:user_id])
    # @category = Product.find(1).category
  end

  def by_category
    @products = Product.where(category: params[:category])
  end

  def by_seller
    @user = User.find_by(id: params[:user_id])
    @products = @user.products
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @product = @user.products.new(product_params[:product])
    if(@product.save)
      redirect_to user_products_path(@product.user_id)#redirect in case user tries to post another form - brings them to entered view
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save
      redirect_to user_products_path(current_user)
    else
      render 'edit'
    end
  end

  def show_category
    @categories = Product.select('DISTINCT category').map(&:category)
  end

  def show_sellers
    @sellers = User.all.select { |user| user.products.count > 0 }
  end

  def retire
    if @product.stock == 0
      return true
    end
    @product.save
    redirect_to user_products_path(@product.user_id)
  end

  private

  def product_params
    params.permit(product: [:name, :description, :price, :category, :picture_url, :stock, :user_id])
  end

end
