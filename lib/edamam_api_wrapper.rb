require 'httparty'
require 'awesome_print'
# require 'dotenv/load'
# require_relative 'recipe'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  SP_URL = "https://test-es.edamam.com/search?"   # URL for Spanish searches

  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredient, id: nil, key: nil)

    # get valid from to data
    data = self.request_recipes(ingredient, id: id, key: key)

    # return data
    recipes = []

    # check if no results or no response
    if data && data["hits"]
      data["hits"].each do |info|

        recipe_hash = info["recipe"]
        new_recipe = self.create_recipe(recipe_hash)
        recipes << new_recipe
      end
    end

    return recipes
  end

  def self.num_recipes(ingredient, id: nil, key: nil)
    response = self.request_recipes(ingredient, id: id, key: key)
    return response["count"]
  end

  def self.find_recipe(uri, id: nil, key: nil)
    id ||= ID
    key ||= KEY

    url = BASE_URL + "r=#{uri}"
    response = HTTParty.get(url)

    if response && response[0]
      return self.create_recipe(response[0])
    end
  end

  private

  def self.create_recipe(recipe_hash)
    # recipe = info["recipe"]
    new_recipe = Recipe.new recipe_hash["label"],
                  URI.encode(recipe_hash["uri"]),
                  recipe_hash["image"],
                  URI.encode(recipe_hash["url"]),
                  source: recipe_hash["source"],
                  servings: recipe_hash["yield"],
                  diet_labels: recipe_hash["dietLabels"],
                  health_labels: recipe_hash["healthLabels"],
                  ingredients: recipe_hash["ingredientLines"],
                  calories: recipe_hash["calories"],
                  nutrition: recipe_hash["totalNutrients"]
    return new_recipe
  end

  def self.request_recipes(ingredient, id: nil, key: nil)
    id ||= ID
    key ||= KEY

    # guard against nil input (controller will not allow this)
    ingredient = "" if !ingredient

    ingredient = "q=#{(ingredient).gsub(" ", "+")}"
    auth = "app_id=#{id}&app_key=#{key}"
    range = "from=0&to=100"

    url = BASE_URL +
          "&" + auth +
          "&" + ingredient +
          "&" + range

    return HTTParty.get(url)
  end

end
