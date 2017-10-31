require 'httparty'
require 'awesome_print'
require 'dotenv/load'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  SP_URL = "https://test-es.edamam.com/search?"   # URL for Spanish searches

  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredient, from = 0, to = 10)
    ap "getting recipes"
    ingredient = "q=#{ingredient}"
    auth = "app_id=#{ID}&app_key=#{KEY}"
    from = "from=#{from}"
    to = "to=#{to}"


    url = BASE_URL +
          "&" + auth +
          "&" + ingredient +
          "&" + from +
          "&" + to
    puts url

    return HTTParty.get(url)
  end

  def self.num_recipes(ingredient)
    response = self.list_recipes(ingredient)
    return response["count"]
  end
end

response = EdamamApiWrapper.list_recipes("chicken", 20, 21)
ap response.parsed_response
puts response["count"]
puts EdamamApiWrapper.num_recipes("chicken")
