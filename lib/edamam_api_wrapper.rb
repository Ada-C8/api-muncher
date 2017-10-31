require "HTTParty"
require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["EDAMAN_ID"]
  APP_KEY = ENV["EDAMAN_KEY"]

  class ApiError < StandardError
  end
end
