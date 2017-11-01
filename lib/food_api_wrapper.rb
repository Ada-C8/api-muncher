require "httparty"

class FoodApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  TOKEN = ENV["FOOD_TOKEN"]
  APP_ID = ENV["FOOD_ID"]

  def self.find_recipes(search, token = nil)
    token ||= TOKEN
    # search = "?q=#{search_term}"

    url = BASE_URL + "q=#{search}" + "&app_id=#{APP_ID}&app_key=#{token}"
    data = HTTParty.get(url).parsed_response

    if data["hits"]
      found_recipes = data["hits"].map do |recipe_hash|
        Recipe.new(recipe_hash["recipe"]["label"], recipe_hash["recipe"]["url"],
        recipe_hash["recipe"]["image"],
        recipe_hash["recipe"]["ingredientLines"],
        recipe_hash["recipe"]["uri"])
      end
      return found_recipes
    else
      return ["nope", "nothing"]
    end
  end





end
