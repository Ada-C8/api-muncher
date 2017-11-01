require "HTTParty"
require 'pry'

class EdamamApiWrapper
  BASE_URLQ = "https://api.edamam.com/search?q="
  BASE_URLR = "https://api.edamam.com/search?r="
  APP_ID = ENV["EDAMAN_ID"]
  APP_KEY = ENV["EDAMAN_KEY"]

  class ApiError < StandardError
  end

  def self.list_recipes(search_term, key=APP_KEY)
    url = BASE_URLQ + search_term + "&app_id=" + APP_ID + "&app_key=" + key
    # puts "#{url}"
    response = HTTParty.get(url)
    # binding.pry
    check_hits(response)
    recipies_array = []

    response["hits"].each do |recipe_data|
      recipies_array << create_recipe(recipe_data)
    end

    return recipies_array
  end
  #
  # def self.show_recipe(uri, key=APP_KEY)
  #   uri_fix = uri_regex(uri)
  #   url = BASE_URLR + uri_fix + "&app_id=" + APP_ID + "&app_key=" + key
  #
  #   response = HTTParty.get(url)
  #
  # end


private
  # make sure status is 200 okay, and you have at least one search results, otherwise raise ApiError
  def self.check_hits(response)
    unless response.code == 200
      raise ApiError.new("Api call to Edaman failed. Status was #{response.code} #{response.message}")
    else
      if response["count"] < 1
        raise ApiError.new("Api call to Edaman failed to return any results for the search term #{response["q"]}")
      end
    end
  end

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params['recipe']["label"],
      api_params['recipe']["uri"],
      {
        image: api_params['recipe']["image"],
        source: api_params['recipe']["source"],
        url: api_params['recipe']["url"],
        yield: api_params['recipe']['yield'],
        calories: api_params['recipe']['calories'],
        ingredients: api_params['recipe']["ingredients"],
        healthLabels: api_params['recipe']["healthLabels"],
        totalDaily: api_params['recipe']['totalDaily']
      }
    )
  end


  # def self.uri_regex(uri)
  #   return uri.sub(/[#]{1}/, '%')
  # end

  # def build_url(search_term, key=APP_KEY)
  #   return BASE_URL + "?q=" + search_term + "&app_id=" + APP_ID + "&app_key=" + key
  # end
end
