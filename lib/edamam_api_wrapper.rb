require 'httparty'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  KEYS = ENV["EDAMAM_KEYS"]
  ID = ENV["EDAMAM_ID"]

  def self.list_recipes(search)
    url = BASE_URL + "?q=" + search + "&app_id=" + ID + "&app_key=" + KEYS

    data = HTTParty.get(url)

    
  end

end
