require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test db contains fixture order_items" do
    things = Order.find(1).order_items
    things.each do |item|
      assert_equal item.order_id, 1
    end
  end

  test "multiple order_items are included in order" do
    things = Order.find(1).order_items
      assert_equal things.count, 2
  end

  test "order_item has a product id" do
    things = Order.find(2).order_items
    things.each do |item|
    assert_equal item.product_id, 1
    end
  end

  test "order_items has a quantity" do
    things = Order.find(2).order_items
    things.each do |item|
    assert_equal item.quantity, 3
    end
  end

  test "total quantity of items from orders with many sellers" do
    things = Order.find(1).order_items
    total_order_items = []
    things.each do |item|
      total_order_items << item.quantity
    end
    total_num = total_order_items.inject(0){|sum,x| sum + x }
    assert_equal total_num, 3
  end

end
