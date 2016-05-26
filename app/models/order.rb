class Order < ActiveRecord::Base
  validates :status, presence: true

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user

  has_many :destinations


  validates :destination, presence: :true
  validates :origins, presence: :true
    # this is going to filter out information: what is on the form: which is the product destination.
    # that will then be sent to the wrapper
    # destination, origin, weight, order_id

    #need to make a route to set this up
    # see if I can store the user info as a destination?
    # make the method that will filter out the information for the controller,
    # this is breaking it down.


end
