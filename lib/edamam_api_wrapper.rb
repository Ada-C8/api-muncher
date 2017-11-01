require "HTTParty"
require 'recipe' # ask why this didn't happen automatically
class ApiError < StandardError
end

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  BASE_URI = "r=http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(q)
    url = BASE_URL + "q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)
    check_status(response)
    return response
  end

  # response from controller#search
  def self.get_results_from_response(response)
    recipes_array = []
    if response["hits"]
      response["hits"].each do |result|
        recipes_array << self.get_recipe(result)
      end
    end
    return recipes_array
  end

  def self.create_recipe(uri)
    encoded_uri = URI.encode(uri)
    url = BASE_URL + uri + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)
    # Recipe.new(
    #   result[0]["uri"], # uri
    #   result[0]["label"], # name
    #   result[0]["image"], # image
    #   result[0]["source"], # original source
    #   result[0]["url"], # link to original
    #   result[0]["ingredientLines"], # ingredients as an array
    #   {
    #     servings: result[0]["yield"], # servings
    #     # nutritional info
    #     diet: result[0]["dietLabels"], # low-fat, etc
    #     health: result[0]["healthLabels"], # vegetarian, etc
    #     calories: result[0]["calories"] # calories
    #   }
    # )
    return response
  end

  private
  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed: #{response.code}")
    end
  end

  def self.get_recipe(result)
    result_params = result["recipe"]
    return Recipe.new(
      result_params["uri"],
      result_params["label"], # name
      result_params["image"], # image
      result_params["source"], # original source
      result_params["url"], # link to original
      result_params["ingredientLines"], # ingredients as an array
      {
        servings: result_params["yield"], # servings
        # nutritional info
        diet: result_params["dietLabels"], # low-fat, etc
        health: result_params["healthLabels"], # vegetarian, etc
        calories: result_params["calories"] # calories
      }
    )
  end
end
