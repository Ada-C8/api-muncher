require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID_TOKEN = ENV["APP_ID_TOKEN"]
  APP_KEY_TOKEN = ENV["APP_KEY_TOKEN"]

  def self.search_recipes(search)
    encoded_search = URI.encode("#{search}")
    url = BASE_URL + "?q=#{encoded_search}&app_id=#{APP_ID_TOKEN}&app_key=#{APP_KEY_TOKEN}"



    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipes_hash|
        Recipe.new(recipes_hash["recipe"]["uri"], recipes_hash["recipe"]["label"], recipes_hash["recipe"]["image"])
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
