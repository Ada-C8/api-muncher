require "httparty"

class FoodApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  TOKEN = ENV["FOOD_TOKEN"]
  APP_ID = ENV["FOOD_ID"]

  def self.find_recipes(token=nil, search_term)
    token ||= TOKEN
    url = BASE_URL + "?q=#{search_term}&app_id=${#{APP_ID}}&app_key=${#{token}}"


    data = HTTParty.get(url)



end
