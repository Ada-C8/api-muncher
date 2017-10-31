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

    check_hits(response)
    return_recipies = []

    response["hits"].each do |recipe_data|
      return_recipies << create_recipe(recipe_data)
    end

  end

private
  # make sure status is 200 okay, and you have at least one search results, otherwise raise ApiError
  def check_hits(response)
    unless response.code == 200
      raise ApiError.new("Api call to Edaman failed. Status was #{response.code} #{response.message}")
    else
      if response["count"] < 1
        raise ApiError.new("Api call to Edaman failed to return any results for the search term #{response["q"]}")
      end
    end
  end
end
