require 'httparty'
require 'awesome_print'
require 'dotenv/load'
require_relative 'recipe'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  SP_URL = "https://test-es.edamam.com/search?"   # URL for Spanish searches

  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredient, from: 0, to: 10, id: nil, key: nil)
    ap "getting recipes"

    data = self.request_recipes(ingredient, from: from, to: to, id: id, key: key)

    # return data
    recipes = []

    if data["count"] > 0
      data["hits"].each do |info|
      # data["hits"].length.times do |idx|
        # recipe = data["hits"][idx]["recipe"]
        recipe = info["recipe"]
        new_recipe = Recipe.new recipe["label"], recipe["url"], recipe["image"],
                      source: recipe["source"],
                      servings: recipe["yield"],
                      diet_labels: recipe["dietLabels"],
                      health_labels: recipe["healthLabels"],
                      ingredients: recipe["ingredientLines"],
                      calories: recipe["calories"],
                      nutrition: recipe["totalNutrients"]
        recipes << new_recipe
      end
    end

    return recipes
  end

  # avoids iterating over the array to get length
  def self.num_recipes(ingredient, id: nil, key: nil)
    response = self.request_recipes(ingredient, id: id, key: key)
    return response["count"]
  end

  def self.request_recipes(ingredient, from: 0, to: 10, id: nil, key: nil)
    id ||= ID
    key ||= KEY
    ap id
    ap key

    ingredient = "q=#{ingredient}"
    auth = "app_id=#{ID}&app_key=#{KEY}"
    from = "from=#{from}"
    to = "to=#{to}"

    url = BASE_URL +
          "&" + auth +
          "&" + ingredient +
          "&" + from +
          "&" + to
    puts url

    return HTTParty.get(url)
  end
end

recipes = EdamamApiWrapper.list_recipes("chicken")
ap recipes
# puts response["count"]
puts EdamamApiWrapper.num_recipes("chicken")
