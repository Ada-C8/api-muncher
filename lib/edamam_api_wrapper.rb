require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID_TOKEN = ENV["APP_ID_TOKEN"]
  APP_KEY_TOKEN = ENV["APP_KEY_TOKEN"]

  def self.search_recipes(search)
    app_id = APP_ID_TOKEN
    app_key = APP_KEY_TOKEN

    url = BASE_URL + "?q=#{search}&app_id=#{app_id}&app_key=#{app_key}"

    data = HTTParty.get(url)

    if data["recipe"]
      my_recipes = data["recipe"].map do |recipe_hash|
        Recipe.new recipe_hash["uri"], recipe_hash["label"], recipe_hash["image"]
      end

      return my_recipes
    else
      return []
    end
  end

  def self.show_recipe
    app_id = APP_ID_TOKEN
    app_key = APP_KEY_TOKEN
    # uri = @recipe.uri
    # what data structure is uri stored as? class object param... 

    url = BASE_URL + "?q=#{search}&app_id=#{app_id}&app_key=#{app_key}"

    response = HTTParty.get(url)
  end



end
