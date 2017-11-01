require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  TOKEN = ENV['EDAMAM_KEY']
  APP_ID = ENV['EDAMAM_ID']

  def self.search(query, token = nil)
    token ||= TOKEN
    url = BASE_URL + "search?q=#{query}&app_id=#{APP_ID}&app_key=#{token}"

    data = HTTParty.get(url)

    if data["recipes"]
      recipes = data["recipes"].map do |recipe_hash|
        Recipe.new(recipe_hash["label"], recipe_hash["image"], recipe_hash["source"], recipe_hash["url"], recipe_hash["ingredientLines"], recipe_hash["totalNutrients"])
      end
      return recipes
    else
      return []
    end
  end
