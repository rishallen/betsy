require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test db contains seeded order"
    things = Order.find(1).order_items
    assert_equal things.orders, 1
    
end
