require 'httparty'

class EdamamApiWrapper
  # Your code here!

  BASE_URL = "https://api.edamam.com/search"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["Application_ID"]


  def self.list_recipes(search)
    url = BASE_URL + "?q=" + search + "&app_id=" + ID + "&app_key=" + KEY
    data = HTTParty.get(url)

    if data["hits"]
      my_hits = data["hits"].map do |hit_hash|
        Recipe.new hit_hash["recipe"]["label"], hit_hash["recipe"]["ingredientLines"]
      end
      return my_hits
    else
      return []
    end

  end
end
