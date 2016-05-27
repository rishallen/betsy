require 'httparty'
# module
module ShippingWrapper
  # this is our api
  # BASE_URL = "boiling-caverns-39725.herokuapp.com"
  BASE_URL = "http://localhost:3001"

  def self.get_rates(order, destination, order_route_array)
    response = HTTParty.post(BASE_URL + "/shipping_rates", {
       :body =>
        :destination => destination
        :origins => order_route_array
        :order => order
        }.to_json,
        :headers => {
          'Content-Type' => 'application/json', 'Accept' => 'application/json'
        } )
  end

  def self.response_rates
    @return_rates = []
    rates = HTTParty.get(BASE_URL + "/shipping_rates/#{order_id}").parsed_response
    @return_rates << rates
  end
end
