require 'httparty'

class RecpieApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  #TOKEN = ENV["SLACK_TOKEN"]

  def self.recpie_query(query)
    url = BASE_URL + "q=#{query}"
    data = HTTParty.get(url)
    if data["hits"]
      return data["hits"]
    else
      return []
    end
  end

  def self.recpie_details(url)
    url = BASE_URL  + "r=#{url}"
    response = HTTParty.get(url)

    return response
  end
end
