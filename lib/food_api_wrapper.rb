require "httparty"

class FoodApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  TOKEN = ENV["FOOD_TOKEN"]
  APP_ID = ENV["FOOD_ID"]

  def self.find_recipes(search, token = nil)
    token ||= TOKEN

    url = BASE_URL + "q=#{search}" + "&app_id=#{APP_ID}&app_key=#{token}"
    data = HTTParty.get(url).parsed_response

    if data["hits"]
      found_recipes = data["hits"].map do |recipe_hash|
        Recipe.new(recipe_hash["recipe"]["label"], recipe_hash["recipe"]["url"],
        recipe_hash["recipe"]["image"],
        recipe_hash["recipe"]["ingredientLines"],
        recipe_hash["recipe"]["uri"],
        recipe_hash["recipe"]["healthLabels"])
      end
      return found_recipes
    else
      return ["nope", "nothing"]
    end
  end

  def self.show_recipe(uri, token=nil)
    token ||= TOKEN

    uri["#"] = "%23"

    url = BASE_URL + "r=#{uri}" + "&app_id=#{APP_ID}&app_key=#{token}"

    data = HTTParty.get(url).parsed_response
    if data.length > 0
      show_recipe = data[0]
      recipe = Recipe.new(show_recipe["label"], show_recipe["url"],
      show_recipe["image"],
      show_recipe["ingredientLines"],
      show_recipe["uri"],
      show_recipe["healthLabels"])
      return recipe
    else
      return ["nope", "nothing"]
    end

  end


end
