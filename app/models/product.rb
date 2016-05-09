class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
  validates :stock, presence: true

  has_many :reviews
  belongs_to :user
  has_many :cart_entries
  has_many :carts, through: :cart_entries
  has_many :order_items
  has_many :orders, through: :order_items

  before_save { |product| product.category = product.category.downcase }

  def show_category
    Product.select('DISTINCT category').map(&:category)
  end
end
