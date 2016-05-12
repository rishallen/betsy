class Review < ActiveRecord::Base
  validates :rating, presence: true
  validates :product_id, presence: true

  belongs_to :user
  belongs_to :product
end
