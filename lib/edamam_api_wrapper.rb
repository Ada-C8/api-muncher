require "HTTParty"
class ApiError < StandardError
end

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(q)
    url = BASE_URL + "q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    check_status(url)
    return HTTParty.get(url)
  end

  private
  def self.create_recipe(response)
    response = self.search(params[:q])

    results = response.hits.map do |result|
      result[:recipe][:label], # name
      result[:recipe][:image], # image
      result[:recipe][:source], # original source
      result[:recipe][:url], # link to original
      result[:recipe][:yield], # servings
      result[:recipe][:dietLabels], # low-fat, etc
      result[:recipe][:healthLabels], # vegetarian, etc
      result[:recipe][:ingredientLines], # ingredients as an array
      result[:recipe][:calories] # calories
    end
    return results
  end

  def self.check_status(response)
    unless response["ok"]
      raise ApiError.new("API call to Edamam failed: #{response["error"]}")
    end
  end
end
