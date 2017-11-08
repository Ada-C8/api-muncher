require 'httparty'

class RecipeApiWrapper
  attr_reader :servings, :uri, :label, :link, :ingredients, :image, :servings, :health_labels, :bookmarked
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.recipe_query(query, from)
    url = BASE_URL +
          "?app_id=#{APP_ID}"+
          "&app_key=#{APP_KEY}" +
          "&q=#{query}"+
          "&from=#{from}"

    data = HTTParty.get(url)
    if data["hits"]
      result = []
      data["hits"].each do |item|
        label = item["recipe"]["label"]
        uri = item["recipe"]["uri"].split("#")[1]
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

  def self.recipe_details(uri)
    url = BASE_URL + "?app_id=#{APP_ID}"+ "&app_key=#{APP_KEY}" + "&r=http://www.edamam.com/ontologies/edamam.owl%23#{uri}"
    response = HTTParty.get(url)
    return response
  end
end
