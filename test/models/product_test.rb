require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "does not save product without name" do
    prod = Product.new(price: 3, stock:100, user_id:1)
    assert_not prod.save
  end

  test "does not save product without price" do
    prod = Product.new(name: "Magic Beans", stock:100, user_id:1)
    assert_not prod.save
  end

  test "does not save product without stock" do
    prod = Product.new(name: "Magic Beans", price: 3, user_id:1)
    assert_not prod.save
  end

  test "does not save product without user_id" do
    prod = Product.new(name: "Magic Beans", price: 3, stock:100)
    assert_not prod.save
  end

  test "saves product when given name, price, stock and user_id" do
    prod = Product.new(name: "Magic Beans", price: 3, stock:100, user_id:1)
    assert prod.save
  end

  test "product belongs to user" do
    prod = Product.find(1)
    assert_equal prod.user_id, 1
  end

end
