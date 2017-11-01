require 'httparty'

class EdamamApiWrapper
  KEY = ENV['EDAMAM_KEY']
  ID = ENV['EDAMAM_ID']
  BASE_URL = 'https://api.edamam.com/search?'

  def self.find_recipes(search_terms)
    url = BASE_URL + 'q=' + "#{search_terms}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    ap url

    response = HTTParty.get(url)
    if response.success?
      return Search.new(response)
    else
      return false
    end
  end

  def self.show_recipe(uri)

    url = BASE_URL + 'r=' + "#{uri}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    response = HTTParty.get(url)

    if response.success?
      return response
    else
      return false
    end
  end


end
