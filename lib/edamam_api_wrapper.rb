require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  ID = ENV["EDAMAM_ID"]
  TOKEN = ENV["EDAMAM_KEY"]

  def self.search_recipes(token = nil)
    token ||= TOKEN
    url = BASE_URL + "?q=" + "search" + "&app_id=#{ID}&app_key=#{token}"
    data = HTTParty.get(url)

    if data["hits"]
      return data["hits"]
    else
      return []
    end
  end

end
