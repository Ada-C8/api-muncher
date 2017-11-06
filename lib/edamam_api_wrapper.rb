require "httparty"
class ApiError < StandardError
end

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  BASE_URI = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.get_search_url(q, from, to)
    return BASE_URL + "q=#{q}&from=#{from}&to=#{to}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
  end

  def self.search(q, from, to)
    url = self.get_search_url(q, from, to)
    response = HTTParty.get(url)
    check_status(response)
    return response
  end

  # response from controller#search
  def self.get_results_from_response(response)
    recipes_array = []
    if response["hits"]
      response["hits"].each do |result|
        recipes_array << self.get_recipe(result["recipe"])
      end
    end
    return recipes_array
  end

    # to get the full url incl. uri
    def self.create_recipe(uri)
      uri = uri.split("_")[-1]
      url = BASE_URL + "r=" + BASE_URI + uri + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
      response = HTTParty.get(url)
      return get_recipe(response[0])
    end

  private
  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed: #{response.code}")
    end
  end

  def self.get_recipe(result)
    return Recipe.new(
      result["uri"], # uri
      result["label"], # name
      {
        image: result["image"], # image
        source: result["source"], # original source
        url: result["url"], # link to original
        ingredients: result["ingredients"], # ingredients as an array
        servings: result["yield"], # servings
        # nutritional info
        diet: result["dietLabels"], # low-fat, etc
        health: result["healthLabels"], # vegetarian, etc
        calories: result["calories"] # calories
      }
    )
  end
end
