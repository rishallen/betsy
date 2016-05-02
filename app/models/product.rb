class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :user_id, presence: true
  validates :stock, presence: true

  has_many :reviews
  belongs_to :user
end
