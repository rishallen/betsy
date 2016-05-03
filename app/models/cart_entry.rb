class CartEntry < ActiveRecord::Base
  validates :cart_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true

  belongs_to :cart
  belongs_to :product
end
