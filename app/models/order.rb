class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :status, presence: true
  validates :mailing_address, presence: true
  validates :cc_digits, presence: true
  validates :expiration, presence: true

  has_many :order_items
end
