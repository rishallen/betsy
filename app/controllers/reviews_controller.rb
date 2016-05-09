class ReviewsController < ApplicationController
  def new
    # unless
    if (session[:user_id] == Product.find(params[:product_id]).user_id)
        flash[:nope] = "Nope - You can't leave a review for your own product!!!"
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      @review = Review.new
      # @user = User.find(id: session[:user_id])
      render :new
    end
  end

  def create
  user = create_review_params[:review]
  user[:user_id] = session[:user_id]
    @review = Review.new(user)
    if @review.save
      flash[:sucess] = "Success!!"
      redirect_to root_path
    else
      render :new
    end
  end

    private
    def create_review_params
      params.permit(review: [:user_id, :rating, :product_id, :content]) #double check attributes
    end
end
