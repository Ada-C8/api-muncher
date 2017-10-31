#require "httparty"
#require 'pry'

class EdemamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY= ENV["APP_KEY"]
  END_URL = "&app_id=$#{APP_ID}&app_key=$#{APP_KEY}"

  def self.list_recipes(search_term)
    puts "Searching for #{search_term}"
    url = BASE_URL + "q=" + search_term
    response = HTTParty.post(url)
    hits = response.parsed_response["hits"]
    return hits
    puts "hits #{hits}"
    puts "hits.length #{hits.length}"
    if hits
      hits.each do |hit|
        label = hit["recipe"]["label"]
        share_url = hit["recipe"]["shareAs"]
        ingredients = hit["recipe"]["ingredientLines"]
        dietary = hit["recipe"]["healthLabels"]
  #next make a recipe object!
      end
    end
    return hits
  end
end
