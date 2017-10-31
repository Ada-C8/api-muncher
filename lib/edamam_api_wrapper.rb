require "HTTParty"
require 'pry'

class EdamamApiWrapper
  BASE_URL = "url here"
  TOKEN = ENV["token here"]

  class ApiError < StandardError
  end
end
