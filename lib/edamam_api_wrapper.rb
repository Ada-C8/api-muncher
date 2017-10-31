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
  def self.create_recipe(api_params)
    return Recipe.new(

    )
  end

  def self.check_status(response)
    unless response["ok"]
      raise ApiError.new("API call to Edamam failed: #{response["error"]}")
    end
  end
end
