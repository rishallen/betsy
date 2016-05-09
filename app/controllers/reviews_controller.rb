class ReviewsController < ApplicationController
  def new
    # unless
      if (session[:user_id] == Product.find(params[:product_id]).user_id)
        root_path
      else
      @review = Review.new
      @user = User.find_by(id: session[:user_id])
      @product = Product.find_by(params[:product_id])
      render new_product_review_path
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
