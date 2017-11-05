require 'httparty'
require 'uri'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  KEYS = ENV["EDAMAM_KEYS"]
  ID = ENV["EDAMAM_ID"]
  RECIPE_URI_PREFIX = 'http://www.edamam.com/ontologies/edamam.owl%23'

  def self.list_recipes(search_term)
    url = BASE_URL + "?q=" + search_term + "&app_id=" + ID + "&app_key=" + KEYS + "&to=50"

    data = HTTParty.get(url)
      if data["hits"]  #hits is an array of recipe hashes {recipe: {url: "string"}}
        my_results = data["hits"].map do |results_hash|
          recipe_uri = URI.parse(results_hash["recipe"]["uri"])
          recipe_id = recipe_uri.fragment
          recipe_image = URI.encode(results_hash["recipe"]["image"])
          Recipe.new results_hash["recipe"]["label"], recipe_id, recipe_image
        end
        return my_results
      else
        return []
      end
  end

  def self.show_recipe(uri)
    url = BASE_URL + "?app_id=" + ID + "&app_key=" + KEYS + "&r=" + RECIPE_URI_PREFIX + URI.encode(uri)

    response = HTTParty.get(url)
    image = URI.encode(response[0]["image"])
    RecipeShow.new response[0]["label"], response[0]["url"], response[0]["ingredientLines"], response[0]["healthLabels"], image, response[0]["source"]
  end

end
