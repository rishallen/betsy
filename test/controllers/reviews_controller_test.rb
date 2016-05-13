require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new, {product_id: 1, user_id: users(:suze).id}
    assert_response :success
    assert_not_nil assigns(:review)
  end

  # test "should create review" do
  # assert_difference('Review.count') do
  #   post :create, review: {title: 'Some title', product_id: products(:one).id, user_id: users(:suze).id}
  # end
  #
  # assert_redirected_to root_path
  # end
end
