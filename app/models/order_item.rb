class OrderItem < ActiveRecord::Base
  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true

  belongs_to :order
  belongs_to :product
end
