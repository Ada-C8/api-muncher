require "HTTParty"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search(term)
    # use API to colelct results
  end
end
