require "HTTParty"
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["EDAMAN_ID"]
  APP_KEY = ENV["EDAMAN_KEY"]

  class ApiError < StandardError
  end

  def self.list_recipes(search_term)
    url = BASE_URL + "?q=" + search_term + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    response = HTTParty.get(url)
    # binding.pry
    check_hits(response)
    recipies_array = []

    response["hits"].each do |recipe_data|
      recipies_array << create_recipe(recipe_data)
    end

    return recipies_array
  end

private
  # make sure status is 200 okay, and you have at least one search results, otherwise raise ApiError
  def self.check_hits(response)
    unless response.code == 200
      raise ApiError.new("Api call to Edaman failed. Status was #{response.code} #{response.message}")
    else
      if response["count"] < 1
        raise ApiError.new("Api call to Edaman failed to return any results for the search term #{response["q"]}")
      end
    end
  end

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params['recipe']["label"],
      api_params['recipe']["uri"],
      {
        image: api_params['recipe']["image"],
        source: api_params['recipe']["source"],
        url: api_params['recipe']["url"],
        yield: api_params['recipe']['yield'],
        calories: api_params['recipe']['calories'],
        ingredients: api_params['recipe']["ingredients"],
        healthLabels: api_params['recipe']["healthLabels"],
        totalDaily: api_params['recipe']['totalDaily']
      }
    )
  end
end
