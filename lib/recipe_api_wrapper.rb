require 'httparty'

class RecipeApiWrapper
  attr_reader :servings, :uri, :label, :link, :ingredients, :image, :servings, :health_labels, :bookmarked
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.recipe_query(query)
    url = BASE_URL + "?app_id=#{APP_ID}"+ "&app_key=#{APP_KEY}" + "&q=#{query}"
    data = HTTParty.get(url)
    if data["hits"]
      result = []
      data["hits"].each do |item|
        label = item["recipe"]["label"]
        uri = item["recipe"]["uri"]
        image = item["recipe"]["image"]
        result.push(
          {
            label: label,
            uri: uri,
            image: image
          }
        )
      end
      return result
    else
      return []
    end
  end

  def self.recipe_details(url)
    url = BASE_URL + "?app_id=#{APP_ID}"+ "&app_key=#{APP_KEY}" + "&r=#{uri}"
    @response = HTTParty.get(url)
  end
end
