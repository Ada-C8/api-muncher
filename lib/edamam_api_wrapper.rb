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
        Recipe.new(name: recipe_hash["label"], image: recipe_hash["image"], source: recipe_hash["source"], url: recipe_hash["url"], ingredients: recipe_hash["ingredientLines"], nutrition: recipe_hash["totalNutrients"])
      end
      return recipes
    else
      return []
    end
  end
end
