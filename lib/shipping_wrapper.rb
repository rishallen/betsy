require 'httparty'
# module
module ShippingWrapper
  # this is our api
  BASE_URL = "boiling-caverns-39725.herokuapp.com"

  def self.get_rates(order, destination, origins)
    response = HTTParty.post(BASE_URL + "/shipping_rates", [{
       :body =>
        "destination": {
          country: destination[:destination][:country],
          state: destination[:destination][:state],
          city: destination[:destination][:city],
          zip: destination[:destination][:zip]
        },

        "origins": {
          country: origins[:country],
          state: origins[:state],
          city: origins[:city],
          zip: origins[:zip],
          quantity: origins[:quantity],
          weight: origins[:weight]
          item_id: origins[:item]
      },

      "order": {
        order_id: order[:][:item_id]
      } }.to_json,

      :headers => {
        'Content-Type' => 'application/json', 'Accept' => 'application/json'
      }])
  end

  def self.response_rates
    @return_rates = []
    rates = HTTParty.get(BASE_URL + "/shipping_rates/#{order_id}").parsed_response
    @return_rates << rates
  end
end
