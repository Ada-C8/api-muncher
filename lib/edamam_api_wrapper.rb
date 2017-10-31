require 'httparty'
require 'awesome_print'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search(term = "thanksgiving")
    url = BASE_URL + "search?q=#{term}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&from=0" + "&to=5"

    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        Recipe.new recipe_hash["recipe"]["uri"], recipe_hash["recipe"]["label"], image: recipe_hash["recipe"]["image"], ingredients: recipe_hash["recipe"]["ingredients"]  # , dietaryinfo: recipe_hash["recipe"]["dietaryinfo"]
      end
    else
      return []
    end
  end
end
