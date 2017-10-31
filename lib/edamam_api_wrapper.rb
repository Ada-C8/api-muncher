require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.list_recipes(search)
    #takes in search as a string, uses whitespace to seperate
    url = BASE_URL + "search?q=#{search}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    data = HTTParty.get(url)

    if data["hits"]
      recipes = data["hits"].map do |recipe_hash|
        Recipe.new url: recipe_hash["recipe"]["url"], label: recipe_hash["recipe"]["label"], ingredients: recipe_hash["recipe"]["ingredientLines"], image: recipe_hash["recipe"]["image"], source: recipe_hash["recipe"]["source"], diet_labels: recipe_hash["recipe"]["dietLabels"], health_labels: recipe_hash["recipe"]["healthLabels"]
      end
      return recipes
    else
      return []
    end
  end
end
