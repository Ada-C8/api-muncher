require 'httparty'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]


  def self.list_recipes(query)
    url = BASE_URL + "?q=#{query}" + "&app_id=#{APP_ID}&app_key=#{APP_KEY}"
    ap url
    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        ap recipe_hash
        Recipe.new recipe_hash["recipe"]["label"]
      end
      return my_recipes
    else
      return []
    end
  end
end
