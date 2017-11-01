require "httparty"

class EdamamWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  ID = ENV["API_ID"]
  KEY = ENV["API_KEY"]


  # def initialize(response)



  def self.list_recipes(item)
    url = BASE_URL + item + "id=#{ID}" + "key=#{KEY}"
    puts url
    data = HTTParty.get(url)
    if data["item"]
      return data["item"]
    else
      return []
    end
  end
end
