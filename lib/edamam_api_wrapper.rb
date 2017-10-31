require 'httparty'

class EdamamApiWrapper
  KEY = ENV['EDAMAM_KEY']
  ID = ENV['EDAMAM_ID']
  BASE_URL = 'https://api.edamam.com/search?q='
  #
  # def initialize(response)
  #   @title = response['recipe']['label']
  # end

  def self.find_recipes(search_terms)
    url = BASE_URL + "#{search_terms}" + "&app_id=#{ID}" + "&app_key=#{KEY}"

    response = HTTParty.get(url)
    response['hits'].each do |response|
      new(response)
    # if response.success?
    #   new(response)
    # end
  end


end
