require 'httparty'
require 'uri'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  KEYS = ENV["EDAMAM_KEYS"]
  ID = ENV["EDAMAM_ID"]
  RECIPE_URI_PREFIX = 'http://www.edamam.com/ontologies/edamam.owl#'

  def self.list_recipes(search_term)
    url = BASE_URL + "?q=" + search_term + "&app_id=" + ID + "&app_key=" + KEYS

    data = HTTParty.get(url)
      if data["hits"]  #hits is an array of recipe hashes {recipe: {url: "string"}}
        my_results = data["hits"].map do |results_hash|
          recipe_uri = URI.parse(results_hash["recipe"]["uri"])
          recipe_id = recipe_uri.fragment
          Recipe.new results_hash["recipe"]["label"], recipe_id
        end
        return my_results
      else
        return []
      end
  end

  def self.show_recipes
    url = BASE_URL + "?r=" + RECIPE_URI_PREFIX + recipe_id
  end

end
