require 'HTTParty'
require 'ap'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  def self.search(query)
    url = BASE_URL + "search?q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    data = HTTParty.get(url)
    # ap data
    if data["hits"]
      return data["hits"]
    else
      return []
    end
  end
end
