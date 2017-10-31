require "httparty"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.search_recipes(query)
    puts "Querying recipe"
    url = BASE_URL + "q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    return response.parsed_response['hits']
  end

  def self.show_recipe(uri)
    request = "http://www.edamam.com/ontologies/edamam.owl%23"
    url = BASE_URL + "r=#{request}#{uri}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    return response
  end
end
