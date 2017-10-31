require 'httparty'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]


  def self.list_recipes(query)
    url = BASE_URL + "?q=#{query}" + "&app_id=#{APP_ID}&app_key=#{APP_KEY}"
    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        Recipe.new recipe_hash["recipe"]["label"],
        recipe_hash["recipe"]["uri"]
      end
      return my_recipes
    else
      return []
    end
  end

  def self.get_recipe(id)
    url = BASE_URL + "?r=#{ERB::Util.u(id)}" + "&app_id=#{APP_ID}&app_key=#{APP_KEY}"
    data = HTTParty.get(url).parsed_response
    Recipe.new data.first["label"], data.first["uri"]
  end

end
