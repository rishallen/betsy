require 'httparty'
# module
module ShippingWrapper
  # this is our api
  # BASE_URL = "boiling-caverns-39725.herokuapp.com"
  BASE_URL = "http://localhost:3001/shippings"

  def self.get_rates(order, destination, order_route_array)
    response = HTTParty.post(BASE_URL + "/shipping_rates", :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
    body: { :origins => order_route_array, :destination => destination, :order => order.id }.to_json )
    binding.pry
  end
end
