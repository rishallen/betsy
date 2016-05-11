require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test db contains seeded order" do
    things = Order.find(1).order_items
    things.each do |item|
      assert_equal item.order_id, 1
    end
  end

  test "does not save order without status" do
    things = Order.new
    assert_not things.save
  end

  test "saves order with status" do
    things = Order.new(status: "pending")
    assert things.save
  end


  test "order belongs to user" do
    things = Order.find(1)
    assert_equal things.user_id, 1
  end

end
