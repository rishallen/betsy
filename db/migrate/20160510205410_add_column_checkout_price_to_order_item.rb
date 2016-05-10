class AddColumnCheckoutPriceToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :checkout_price, :integer
  end
end
