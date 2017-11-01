require 'httparty'
require 'awesome_print'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.item_search(item_uri)

    url = BASE_URL + "r=#{item_uri}" "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    data = HTTParty.get(url)

    recipe = Recipe.new(
      data[0]["uri"],
      data[0]["label"],
      image: data[0]["image"],
      ingredients: data[0]["ingredientLines"],
      url: data[0]["url"],
      calories: data[0]["calories"],
      totalNutrients: data[0]["totalNutrients"],
      )

    return recipe
  end

  def self.search(term = "thanksgiving")
    url = BASE_URL + "q=#{term}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&from=0" + "&to=5"

    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        Recipe.new(
        recipe_hash["recipe"]["uri"],
        recipe_hash["recipe"]["label"],
        image: recipe_hash["recipe"]["image"],
        ingredients: recipe_hash["recipe"]["ingredientLines"],
        url: recipe_hash["recipe"]["url"],
        dietaryInfo: {
          calories: recipe_hash["recipe"]["calories"],
          totalNutrients: recipe_hash["recipe"]["dietaryInfo"],
          } )
      end
    else
      return []
    end
  end
end
