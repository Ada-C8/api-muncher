require "HTTParty"
require 'pry'

class SlackApiWrapper
  BASE_URL = "https://api.edamam.com/"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["EDAMAM_ID"]

  def some_method
    chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=gte%20591,%20lte%20722&health=alcohol-free
    url = BASE_URL + "search?q=" + search_term + "app_id=" + "&app_key=$token=#{KEY}" +
  end



end
