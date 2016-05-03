class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :reviews, :orders, :products
  #has_secure_password
end
