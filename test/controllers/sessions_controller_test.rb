require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a new session" do
    session[:user_id] = nil
    session[:order_id] = nil
    post :create, {email: "suze@suze", password: "password"}
    refute_nil session[:user_id]
    refute_nil session[:order_id]
    assert_redirected_to root_path
  end

  test "should not create a new session" do
    session[:user_id] = nil
    session[:order_id] = nil
    post :create, {email: "suze@done", password: "password"}
    assert_nil session[:user_id]
    assert_nil session[:order_id]
    assert_response :success
  end

  test "should delete session user_id" do
    session[:user_id] = 3
    delete :destroy
    assert_nil session[:user_id]
  end

  test "should delete session order_id" do
    session[:order_id] = 3
    delete :destroy
    assert_nil session[:order_id]
  end

  test "should redirect is root path" do
    delete :destroy
    assert_redirected_to root_path
  end
end
