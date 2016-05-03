class ProductsController < ApplicationController

  def index
      @all_products = Product.order(category: :asc)
      render :index
    end

    def show
      @product = Product.find(params[:id])
      render :show
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_create_params[:product])
      if(@product.save)
        redirect_to product_path(@product.id)#redirect in case user tries to post another form - brings them to entered view
      else
        render :new
      end
    end


end
