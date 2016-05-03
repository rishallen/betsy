class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :status, presence: true
  validates :mailing_address, presence: true
  validates :cc_digits, presence: true, length: { is: 4 }
  validates :expiration, presence: true

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user

end
