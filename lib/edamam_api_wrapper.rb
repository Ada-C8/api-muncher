require 'HTTParty'
require 'ap'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  MINIMUM_BAR = %w(label uri image ingredientLines)

  def self.search(query, hits)
    url = BASE_URL + "search?q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&to=#{hits}"

    data = HTTParty.get(url)

    if data["hits"]
      recipe_hits = data["hits"].map do |hit|
        if self.complete?(hit)
          Recipe.new(
            hit["recipe"]["label"],
            hit["recipe"]["uri"],
            hit["recipe"]["image"],
            hit["recipe"]["ingredientLines"],
            external_url: hit["recipe"]["url"],
            source: hit["recipe"]["source"]
          )
        end
      end
      return recipe_hits
    else
      return []
    end
  end

  def self.complete?(hit)
    MINIMUM_BAR.each do |bar|
      unless hit["recipe"][bar]
        return false
      end
      return true
    end

  end
end
