require "HTTParty"
require 'recipe' # ask why this didn't happen automatically
class ApiError < StandardError
end

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  BASE_URI = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(q)
    url = BASE_URL + "q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)
    check_status(response)
    return response
  end

  def self.get_results_from_response(response)
    return response["hits"].map do |result|
      Recipe.new(
        result["recipe"]["uri"]
        result["recipe"]["label"], # name
        result["recipe"]["image"], # image
        result["recipe"]["source"], # original source
        result["recipe"]["url"], # link to original
        result["recipe"]["ingredientLines"], # ingredients as an array
        {
          servings: result["recipe"]["yield"], # servings
          # nutritional info
          diet: result["recipe"]["dietLabels"], # low-fat, etc
          health: result["recipe"]["healthLabels"], # vegetarian, etc
          calories: result["recipe"]["calories"] # calories
        }
      )
    end
  end

# http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
  def self.get_id(r)
    uri = BASE_URI + "#{r}" # + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    id = HTTParty.get(uri)
    return id
  end

  private
  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed: #{response.code}")
    end
  end
end
