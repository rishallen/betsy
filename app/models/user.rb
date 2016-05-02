class User < ActiveRecord::Base
  has_many :reviews, :orders, :products
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
end
