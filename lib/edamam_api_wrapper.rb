require "httparty"
require "awesome_print"

class EdamamApiWrapper
  # Your code here!
  BASE_URL = "https://api.edamam.com/"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  def self.search_recipes(query, app_key = nil, app_id = nil)
    app_key ||= APP_KEY
    app_id ||= APP_ID
    query = URI.encode(query)
    url = BASE_URL + "search?app_key=#{app_key}" + "&app_id=#{app_id}" + "&q=#{query}" # 1 = true, 0 = false

    data = HTTParty.get(url)

    if data["hits"] && data["hits"].count > 0
      recipes = data["hits"].map do |recipe_hash|
        Recipe.new(
          recipe_hash["recipe"]["label"],
          recipe_hash["recipe"]["url"],
          recipe_hash["recipe"]["ingredientLines"],
          dietary_info: recipe_hash["recipe"]["dietLabels"],
          health_info: recipe_hash["recipe"]["healthLabels"],
          image: recipe_hash["recipe"]["image"],
          source: recipe_hash["recipe"]["source"],
          yield:recipe_hash["recipe"]["yield"])
      end
      return recipes
    else
      return[]
    end
  end
end
