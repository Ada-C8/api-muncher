require "HTTParty"
class ApiError < StandardError
end

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(q)
    url = BASE_URL + "q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)
    check_status(response)
    return response
  end

  def self.get_results_from_response(response)
    return response["hits"].map do |result|
      {
        name: result["recipe"]["label"], # name
        # image: result["recipe"]["image"], # image
        # source: result["recipe"]["source"], # original source
        # url: result["recipe"]["url"], # link to original
        # servings: result["recipe"]["yield"], # servings
        # diet: result["recipe"]["dietLabels"], # low-fat, etc
        # health: result["recipe"]["healthLabels"], # vegetarian, etc
        # ingredients: result["recipe"]["ingredientLines"], # ingredients as an array
        # calories: result["recipe"]["calories"] # calories
      }
    end
  end

  private
  def self.check_status(response)
    unless response.code == 200
      raise ApiError.new("API call to Edamam failed: #{response.code}")
    end
  end
end
