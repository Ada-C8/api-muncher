require 'httparty'
require 'awesome_print'
# require 'dotenv/load'
# require_relative 'recipe'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  SP_URL = "https://test-es.edamam.com/search?"   # URL for Spanish searches

  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredient, from: 0, to: 10, id: nil, key: nil)

    # get valid from to data
    data = self.request_recipes(ingredient, from: from, to: to, id: id, key: key)

    # return data
    recipes = []

    # check if no results or no response
    if data && data["hits"]
      data["hits"].each do |info|
      # data["hits"].length.times do |idx|
        # recipe = data["hits"][idx]["recipe"]
        recipe_hash = info["recipe"]
        new_recipe = self.create_recipe(recipe_hash)
        # recipe = info["recipe"]
        # new_recipe = Recipe.new recipe["label"],
        #               URI.encode(recipe["uri"]),
        #               recipe["image"],
        #               URI.encode(recipe["url"]),
        #               source: recipe["source"],
        #               servings: recipe["yield"],
        #               diet_labels: recipe["dietLabels"],
        #               health_labels: recipe["healthLabels"],
        #               ingredients: recipe["ingredientLines"],
        #               calories: recipe["calories"],
        #               nutrition: recipe["totalNutrients"]
        recipes << new_recipe
      end
    end

    return recipes
  end

  # what happens if their server is down? how to test?
  # instance variable so accessible by any instance
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
  # private

  def self.request_recipes(ingredient, from: 0, to: 10, id: nil, key: nil)
    id ||= ID
    key ||= KEY

    # ensure from and to are valid input
    valid_req = self.validate_req_range(from, to)
    from = valid_req[:from]
    to = valid_req[:to]

    # guard against nil input (controller will not allow this)
    ingredient = "" if !ingredient

    ingredient = "q=#{(ingredient).gsub(" ", "+")}"
    auth = "app_id=#{id}&app_key=#{key}"
    from = "from=#{from}"
    to = "to=#{to}"

    url = BASE_URL +
          "&" + auth +
          "&" + ingredient +
          "&" + from +
          "&" + to

    return HTTParty.get(url)
  end

  def self.validate_req_range(from, to)
    # coerce into ints
    from = from.to_i
    to = to.to_i

    # ensure > 0
    from = 0 if from < 0

    # if from and to = 0, default to to 10
    to = 10 if to == 0 && from == 0

    # return 1 result if from == to
    to = from + 1 if to == from

    # else return default 10 if to is neg or < from
    to = from + 10 if to < from

    return { from: from, to: to }
  end
end

  # recipe = EdamamApiWrapper.find_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2")
# recipes = EdamamApiWrapper.list_recipes("chicken")
# ap recipes
# puts response["count"]
# puts EdamamApiWrapper.num_recipes("chicken")
