require 'httparty'
require 'will_paginate/array'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  SEARCH_URL = "q="
  SHOW_URL = "r=http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  CRED_URL = "&app_id=#{ENV["APP_ID"]}&app_key=#{ENV["APP_KEY"]}"
  NUMBER_URL = "&from=0&to=900"

  def self.search_recipes(search)
    url = BASE_URL + SEARCH_URL + "#{search}" + CRED_URL + NUMBER_URL
    response = HTTParty.get(url)
    recipes = []
    if response["hits"]
      response["hits"].each do |recipe_data|
        recipes << create_recipe(recipe_data["recipe"])
      end
    else
      return []
    end
    return recipes
  end

  def self.show_recipe(id)
    url = BASE_URL + SHOW_URL + "#{id}" + CRED_URL
    response = HTTParty.get(url)
    if response.present?
      recipe = create_recipe(response[0])
      return recipe
    end
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["uri"],
      api_params["label"],
      api_params["source"],
      api_params["url"],
      api_params["image"],
      api_params["ingredientLines"],
      api_params["healthLabels"]
    )
  end
end
