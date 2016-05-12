require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  test "test db contains seeded review" do
    review = Review.find(1)
    assert_equal review.id, 1
  end

  test "does not save review without number rating" do
    review = Review.new(content: "reviewstuff", product_id: 2, user_id: 2)
    assert_not review.save
  end

  test "does not save review without product id" do
    review = Review.new(rating: 1, user_id: 2)
    assert_not review.save
  end

  test "saves review with number rating and content" do
    review = Review.new(rating: 3, content: "review", product_id: 2, user_id: 2)
    assert review.save
  end

  test "review belongs to user" do
    review = Review.find(1)
    assert_equal review.user_id, 1
  end


end
