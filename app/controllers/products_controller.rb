class ProductsController < ApplicationController

  def index
    @all_products = Product.order(category: :asc)
    render :index
  end

  def show
    @product = Product.find(params[:id])
    # @review = Review.new(product_id: @product.id)
    # if @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    # else
    #   @order_item = Orderitem.new(product_id: @product.id)
    # end
    render :show
  end

  def new
    @product = Product.new
    # @category = Product.find(1).category
  end

  def by_category
    @category = Product.find_by(category: params[:product])
    @products = @category.products
  end

  def by_seller
    @user = User.find(params[:id])
    @products = @user.products.where(out_of_stock: false)
  end

  def create
    @product = Product.new(product_params[:product])
    if(@product.save)
        redirect_to product_path(@product.id)#redirect in case user tries to post another form - brings them to entered view
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
    params.require(:product).permit([:name, :description, :price, :category, :picture_url, :stock, :user_id])
  end

end
