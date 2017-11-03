require "httparty"
require "uri"

class EdamamWrapper
  BASE_URL = "https://api.edamam.com/search?"
  ID = ENV["API_ID"]
  KEY = ENV["API_KEY"]


  # def initialize(response)

  def self.list_recipes(item)
    url = BASE_URL + "q=#{item}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    # binding.pry
    recipe_list = []
    if data["hits"]
      data["hits"].each do |hit|
        # hit.each do |recipe|
          recipe_list << create_recipe(hit)
      end
      return recipe_list
    end
  end

  def find_recipe(uri)
    url = BASE_URL + "r=#{URI.encode(uri)}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)

    recipe = nil
    if data
      params = data[0]
      params["recipe"]["id"] = get_id(params)
      recipe = self.create_recipe(params)
    end
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["recipe"]["uri"],
      api_params["recipe"]["label"],
      api_params["recipe"]["image"],
      api_params["recipe"]["url"],
      api_params["recipe"]["id"]
      # api_params["recipe"]["calories"],
      # api_params["recipe"]["ingredients"],
    )
  end

  def get_id(params)
    uri = params["recipe"]["uri"]
    arr_uri = uri.split(/recipe_/)
    id = arr_uri[1]
    return id
  end
end
