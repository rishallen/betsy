class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :reviews
  has_many :orders
  has_many :products

  has_secure_password

  def self.log_in(email, password)
    somebody = find_by(email: email)
    somebody && somebody.authenticate(password)
  end
end
