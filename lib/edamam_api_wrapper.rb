require 'httparty'

class EdamamApiWrapper
  KEY = ENV['EDAMAM_KEY']
  ID = ENV['EDAMAM_ID']
  BASE_URL = 'https://api.edamam.com/search?q='

  def self.find_recipes(search_terms)
    url = BASE_URL + "#{search_terms}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    response = HTTParty.get(url)
    if response.success?
      return Search.new(response)
    else
      return flash.now = "Sorry, couldn't find any matching recipes."
    end
  end


end
