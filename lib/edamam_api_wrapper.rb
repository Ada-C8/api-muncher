# lib/edamam_api_wrapper.rb
require 'httparty'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["Edamam_App_ID"]

  # Method to list recipes.

  def self.list_recipes(search_word)
    url = BASE_URL + "q=#{search_word}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    data = HTTParty.get(url)

    if data["hits"]
      recipe_data = data ["hits"].map do |recipe_hash|
        Recipe.new(
          recipe_hash["recipe"]["uri"],
          recipe_hash["recipe"]["label"],
          recipe_hash["recipe"]["image"],
          recipe_hash["recipe"]["ingredientLines"],
          recipe_hash["recipe"]["calories"],
          recipe_hash["recipe"]["url"]
        )
      end
      return recipe_data
    else
      return []
    end


    # Method to show recipes.

    def self.show_recipe(title)
      url = BASE_URL + ""
      data = HTTParty.get(url)

      Recipe.new data
    end
  end
end
