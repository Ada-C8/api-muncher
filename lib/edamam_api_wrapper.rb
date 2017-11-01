require 'httparty'
require 'pry'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  KEYS = ENV["EDAMAM_KEYS"]
  ID = ENV["EDAMAM_ID"]

  def self.list_recipes(search)
    url = BASE_URL + "?q=" + search + "&app_id=" + ID + "&app_key=" + KEYS

    data = HTTParty.get(url)
      if data["hits"]  #hits is an array of recipe hashes {recipe: {url: "string"}}
        my_results = data["hits"].map do |results_hash|
          Recipe.new results_hash["recipe"]["label"], results_hash["recipe"]["label"]
        end
        return my_results
      else
        return []
      end
  end

end
