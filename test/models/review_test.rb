require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  test "test db contains seeded review" do
    review = Review.find(1)
    assert_equal review.id, 1
  end

  test "does not save review without number rating" do
    review = Review.new(content: "reviewstuff")
    assert_not review.save
  end

  test "does not save review without content" do
    review = Review.new(rating: 1)
    assert_not review.save
  end

  test "saves review with number rating and content" do
    review = Review.new(rating: 3, content: "review")
    assert review.save
  end

  test "review belongs to user" do
    review = Review.find(1)
    assert_equal review.user_id, 1
  end


end
