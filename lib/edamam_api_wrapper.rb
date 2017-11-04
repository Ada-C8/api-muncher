require 'httparty'
require 'uri'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  SEARCH_URL = "q="
  SHOW_URL = "r="
  CRED_URL = "&app_id=#{ENV["APP_ID"]}&app_key=#{ENV["APP_KEY"]}"

  def self.search_recipes(search)
    url = BASE_URL + SEARCH_URL + "#{search}" + CRED_URL
    response = HTTParty.get(url)
    recipes = []
    if response["hits"]
      response["hits"].each do |recipe_data|
        recipes << create_recipe(recipe_data)
      end
    else
      return []
    end
    return recipes
  end

  def self.show_recipe(id)
    url = BASE_URL + SHOW_URL + "#{id}" + CRED_URL
    response = HTTParty.get(url)
    recipe = Recipe.new(
      response.first["uri"]
      response.first["label"]
      response.first["url"]
      response.first["image"]
      response.first["ingredientLines"]
      response.first["healthLabels"]
    )
    return recipe
  end




  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["recipe"]["uri"],
      api_params["recipe"]["label"],
      api_params["recipe"]["url"],
      api_params["recipe"]["image"],
      api_params["recipe"]["ingredientLines"],
      api_params["recipe"]["healthLabels"]
    )
  end
end
