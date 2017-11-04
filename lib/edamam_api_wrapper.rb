require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  TOKEN = ENV['EDAMAM_KEY']
  APP_ID = ENV['EDAMAM_ID']

  def self.search(query, token = nil)
    token ||= TOKEN
    url = BASE_URL + "search?q=#{query}&app_id=#{APP_ID}&app_key=#{token}"

    data = HTTParty.get(url)

    if data["hits"]
      recipes = data["hits"].map do |recipe_hash|
        Recipe.new(name: recipe_hash["recipe"]["label"], image: recipe_hash["recipe"]["image"], source: recipe_hash["recipe"]["source"], url: recipe_hash["recipe"]["url"], ingredients: recipe_hash["recipe"]["ingredientLines"], nutrition: recipe_hash["recipe"]["totalNutrients"])
      end
      return recipes
    else
      return []
    end
  end
end
