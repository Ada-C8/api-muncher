require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.list_recipes(search, app_id = nil, app_key = nil)
    #takes in search as a string, uses whitespace to seperate
    #need to pass in optional app keys and ids so I can test bogus tokens etc.

    app_id ||= APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "search?q=#{search}" + "&app_id=#{app_id}" + "&app_key=#{app_key}" + "&from=0" + "&to=100"

    data = HTTParty.get(url)

    if data["hits"]
      recipes = data["hits"].map do |recipe_hash|
        Recipe.new recipe_hash["recipe"]["label"], recipe_hash["recipe"]["url"], recipe_hash["recipe"]["ingredientLines"], recipe_hash["recipe"]["image"], recipe_hash["recipe"]["source"], diet_labels: recipe_hash["recipe"]["dietLabels"], health_labels: recipe_hash["recipe"]["healthLabels"]
      end
      return recipes
    else
      return []
    end
  end

  def self.show_recipe(search, url, app_id = nil, app_key = nil)
    recipes = self.list_recipes(search)

    recipe_array = recipes.select { |recipe| URI.encode(recipe.url) == url}

    recipe = recipe_array[0]
    return recipe
  end
end
