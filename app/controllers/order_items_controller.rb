class OrderItemsController < ApplicationController

  # def edit #Editing orders should only be "PENDING" orders, should be in cart
  #   @order_item = current_order.order_items.find(params[:id])
  #     render cart_path
  # end

  def update

    @order_item = current_order.order_items.where(id: params[:id]).first
    ### OR OrderItems.find(id) ????
    @order_item.update(quantity: params[:quantity])
    redirect_to cart_path
    # binding.pry
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end


  # private
  #
  # def order_item_update_params
  #   params.permit(:quantity)
  # end

end
