class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.log_in(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      session[:order_id] = Order.where(user_id: user.id).length == 0 ? Order.create(user_id: session[:user_id]) : Order.where(user_id: user.id).last.id
      redirect_to root_path
    else
      flash[:wrong_sign_in] = "Wrong Email or Password"
      render :new
    end
  end

  def destroy
    session.delete :user_id
    session.delete :order_id
    redirect_to root_path
  end
end
