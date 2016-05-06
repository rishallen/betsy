require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test db contains seeded order"
    things = Order.find(1).order_items
    things.each do |item|
      assert_equal item.order, 1
    end

end
