require "httparty"
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  class ApiError < StandardError
  end

  def self.search_recipes(query)
    url = BASE_URL + "q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}&from=0&to=2"

    # binding.pry

    response = HTTParty.get(url)

    # check_status(response)

    return response.parsed_response['hits']
  end

  def self.show_recipe(uri)
    request = "http://www.edamam.com/ontologies/edamam.owl%23"
    url = BASE_URL + "r=#{request}#{uri}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    binding.pry

    # check_status(response)

    return response
  end

  private

  # def self.check_status(response)
  #   unless response.code == 200 & response.parsed_response['counts'].length > 0
  #     raise ApiError.new("API call to Edamam failed: #{response["error"]}")
  #   end
  # end
end
