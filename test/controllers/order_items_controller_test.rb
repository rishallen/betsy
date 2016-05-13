require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  test "should update existing order_items" do
    session[:order_id] = order_items(:one).order_id
    post :update, {id: order_items(:one).id, quantity: 3}
    assert_response :redirect
    assert_not_nil assigns(:order_item)
  end

  test "should update delete order_items" do
    session[:order_id] = order_items(:one).order_id
    delete :destroy, {id: order_items(:one).id, quantity: 3}
    assert_response :redirect
    assert_not_nil assigns(:order_item)
  end
end
