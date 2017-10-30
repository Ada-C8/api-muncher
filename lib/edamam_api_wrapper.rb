require 'httparty'
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

#https://api.edamam.com/search?q=chicken&app_id=2c7ae9f0&app_key=866e993b70674c7f28743f4642945fc9&ingr=5

  def self.search(q)
    url = BASE_URL + "/search" + "?q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    binding.pry
    data = HTTParty.get(url)
    puts url
  end
end
