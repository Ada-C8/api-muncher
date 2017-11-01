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

    # get valid from to data

    data = self.request_recipes(ingredient, from: from, to: to, id: id, key: key)

    # return data
    recipes = []

    # check if no results or no response
    if data && data["count"] > 0
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

  # what happens if their server is down? how to test?
  def self.num_recipes(ingredient, id: nil, key: nil)
    response = self.request_recipes(ingredient, id: id, key: key)
    return response["count"]
  end

  # private

  def self.request_recipes(ingredient, from: 0, to: 10, id: nil, key: nil)
    id ||= ID
    key ||= KEY

    # ensure from and to are valid input
    valid_req = self.validate_req_range(from, to)
    from = valid_req[:from]
    to = valid_req[:to]

    ingredient = "q=#{ingredient}"
    auth = "app_id=#{ID}&app_key=#{KEY}"
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

# recipes = EdamamApiWrapper.list_recipes("chicken")
# ap recipes
# # puts response["count"]
# puts EdamamApiWrapper.num_recipes("chicken")
