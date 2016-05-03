class Order < ActiveRecord::Base
  validates :user_id
  validates :status, presence: true
  validates :mailing_address
  validates :cc_digits
  validates :expiration
  validates :session_id, presence: true

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user

end
