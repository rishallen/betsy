require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new, {username: "newuser", email: "a@a", password: "pw"}
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should create user" do
  assert_difference('User.count') do
    post :create, user: {username: "newuser", email: "a@a", password: "pw"}
  end

  assert_redirected_to root_path
  end
end
