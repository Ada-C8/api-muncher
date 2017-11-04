# lib/edamam_api_wrapper.rb
require 'httparty'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["Edamam_App_ID"]

  def self.show_recipe(search_word)

    url = BASE_URL + "r=" + (URI.encode(search_word))

    data = HTTParty.get(url)

    Recipe.new data[0]["uri"],
    data[0]["label"],
    data[0]["image"],
    data[0]["ingredientLines"],
    data[0]["calories"],
    data[0]["url"]
  end

  # Method to list recipes.
  # Created method using Postman to have a better comprehension of how the api works, the information is found, as well as, working with the displayed data (hashes within hashes), utlizing the key value pair to pull only the information necessary/required for my app.  For example, I initially called 'hits', 'recipes'.  I changed it to 'hits' after viewing the JSON results and found that it is in fact called hits and I am taking the 'hits' key to pull the other key 'recipe' and with that calling for the value pair of necessary information that I need for my eventual output.

  def self.list_recipes(search_word)
    # The url I defined/created by using Postman to fully read the get function and how it worked.
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
  end

  # Method to show recipes.


end
