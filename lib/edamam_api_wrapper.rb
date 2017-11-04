require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID_TOKEN = ENV["APP_ID_TOKEN"]
  APP_KEY_TOKEN = ENV["APP_KEY_TOKEN"]

  def self.search_recipes(search)
    encoded_search = URI.encode("#{search}")
    url = BASE_URL + "?q=#{encoded_search}&app_id=#{APP_ID_TOKEN}&app_key=#{APP_KEY_TOKEN}" + "&to=100"



    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipes_hash|
        Recipe.new(recipes_hash["recipe"]["uri"], recipes_hash["recipe"]["label"], recipes_hash["recipe"]["image"], recipes_hash["recipe"]["source"], recipes_hash["recipe"]["url"], recipes_hash["recipe"]["yield"], recipes_hash["recipe"]["ingredientLines"],
        recipes_hash["recipe"]["dietLables"])
      end

      return my_recipes
    else
      return []
    end
  end

  def self.show_recipe(uri)
  #  encode_uri = URI.encode("#{uri}")
    # uri = @recipe.uri
    # what data structure is uri stored as? class object param...

    url = BASE_URL + "?r=#{uri}&app_id=#{APP_ID_TOKEN}&app_key=#{APP_KEY_TOKEN}"

    response = HTTParty.get(url)

  return  Recipe.new(response[0]["uri"], response[0]["label"], response[0]["image"], response[0]["source"], response[0]["url"], response[0]["yield"], response[0]["ingredientLines"], response[0]["dietLabels"])
  end



end
