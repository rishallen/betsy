class ReviewsController < ApplicationController
  def new
    # unless
    if (session[:user_id] == Product.find(params[:product_id]).user_id)
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      @review = Review.new
      # @user = User.find(id: session[:user_id])
      render new_product_review_path(@product.id)
    end
  end

  def create
    @review = Review.new(create_review_params)
    if @review.save
      redirect_to product_path(product.id)
    else
      render :new
    end
  end

    private
    def create_review_params
      params.permit(review: [:user_id, :rating, :product_id, :content]) #double check attributes
    end
end
