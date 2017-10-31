require 'httparty'
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

#https://api.edamam.com/search?q=chicken&app_id=2c7ae9f0&app_key=866e993b70674c7f28743f4642945fc9&ingr=5

  def self.search(q)
    url = BASE_URL + "/search" + "?q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    puts "About to send request for list of channels"
    data = HTTParty.get(url)

    puts "Got response with status: #{data.code}: #{data.message}"
    puts "Parsed response is: #{data.parsed_response}"
    puts "Keys are: #{data.parsed_response.keys}"

    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipes << self.create_recipe(recipe_data)
      end
    end
    return recipe_list
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["label"],
      api_params["url"],
      api_params["image"],
      api_params["ingredients"]
    )
  end
end
