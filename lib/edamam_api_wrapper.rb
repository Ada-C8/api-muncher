require 'httparty'
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  BASE_URI = "?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  class ApiError < StandardError ; end

  def self.search(q, app_id=APP_ID, app_key=APP_KEY)

    url = BASE_URL + "/search" + "?q=#{q}" + "&app_id=#{app_id}" + "&app_key=#{app_key}" + "&to=30"

    puts "About to send request for list of channels"
    data = HTTParty.get(url)
    puts "Got response with status: #{data.code}: #{data.message}"
    # puts "Parsed response is: #{data.parsed_response}"
    # puts "Keys are: #{data.parsed_response.keys}"
    check_status(data)

    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << create_recipe(recipe_data["recipe"])
      end
    end
    return recipe_list
  end

  def self.find_recipe(id, app_id=APP_ID, app_key=APP_KEY)

    url = BASE_URL + "/search" + BASE_URI + "#{id}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    puts "About to send request for one recipe"
    data = HTTParty.get(url)
    # puts "Got response with status: #{data.code}: #{data.message}"
    # puts "Parsed response is: #{data.parsed_response}"
    # puts "Keys are: #{data.parsed_response.keys}"
    check_status(data)

    if data.any?
      create_recipe(data[0])
    else
      raise ApiError.new("That recipe doesn't exist, please search again")
    end
  end

  private

  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed: #{response.code}: #{response.message}")
    end
  end

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["label"],
      api_params["url"],
      api_params["uri"],
      api_params["image"],
      api_params["source"],
      api_params["ingredients"],
      {
        health_labels: api_params["healthLabels"]
      }
    )
  end
end
