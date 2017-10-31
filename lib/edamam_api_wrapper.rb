require 'HTTParty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["app_id"]
  APP_KEY = ENV["app_key"]

  def self.search(query)
    #should search be here or in controller?
    #needs to be encoded
    url = BASE_URL + "?" + "app_id=#{APP_ID}" + "&" + "app_key=#{APP_KEY}" + "&" + query
    encoded_url = URI.encode("#{url}")

    if encoded_url
      return HTTParty.get(encoded_url).parsed_response
    else
      return []
    end
  end

end
