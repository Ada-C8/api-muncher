require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search_recipe_results(search_term)
    # if q
      url = BASE_URL + "search?q=#{search_term}" + "&app_id= ${#{APP_ID}}" + "&app_key= ${#{APP_KEY}}"

    # if r
      url = url = BASE_URL + "search?r=#{search_term}" + "&app_id= ${#{APP_ID}}" + "&app_key= ${#{APP_KEY}}"



  end

end
