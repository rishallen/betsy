class ProductsController < ApplicationController

  def index
    if params[:category]
      by_category
    elsif params[:user_id]
      by_seller
    else
      @products = Product.all #order(category: :asc)
    end
    render :index
  end

  def show
    @product = Product.find(params[:id])
    render :show
  end

  def new
    @product = Product.new
    # @category = Product.find(1).category
  end

  def by_category
    @category = Category.find_by(id: params[:category])
    @products = @category.products
  end

  def by_seller
    @user = User.find_by(id: params[:user_id])
    @products = @user.products
  end

  def create
    @product = Product.new(product_params[:product])
    if(@product.save)
        redirect_to product_path(params[:id])#redirect in case user tries to post another form - brings them to entered view
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
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def out_of_stock
    @product.out_of_stock ? @product.out_of_stock = false : @product.out_of_stock = true
    @product.save
    redirect_to user_path(@product.user_id)
  end

  private

  def product_params
    params.permit(product: [:name, :description, :price, :category, :picture_url, :stock, :user_id])
  end

end
