class Cart < ActiveRecord::Base
  validates :session_id, presence: true

  has_many :cart_entries
  has_many :products, through: :cart_entries
end
