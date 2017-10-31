require 'HTTParty'
require 'ap'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  def self.search(query, hits)
    url = BASE_URL + "search?q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&more=1" + "$to=#{hits}"

    data = HTTParty.get(url)
    # ap data
    if data["hits"]
      recipe_hits = data["hits"].map do |hit|
        Recipe.new(
          hit["recipe"]["label"],
          hit["recipe"]["url"],
          hit["recipe"]["image"],
          hit["recipe"]["source"],
          hit["recipe"]["ingredientLines"]
        )
      end
      return recipe_hits
    else
      return []
    end
  end
end
