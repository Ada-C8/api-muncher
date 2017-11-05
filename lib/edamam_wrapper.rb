require "httparty"
require "uri"

class EdamamWrapper
  BASE_URL = "https://api.edamam.com/search?"
  ID = ENV["API_ID"]
  KEY = ENV["API_KEY"]

  class ApiError < StandardError
  end


  # def initialize(response)

  def self.list_recipes(item, from)
    url = BASE_URL + "q=#{item}" + "&from=#{from}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    # binding.pry

    unless data.ok?
      raise ApiError.new("Call to list recipes failed")
    end

    recipe_list = []
    if data["hits"]
      data["hits"].each do |hit|
        # hit.each do |recipe|
          recipe_list << self.create_recipe(hit["recipe"])
      end
      return recipe_list
    end
  end

  def self.find_recipe(uri)
    url = BASE_URL + "r=#{URI.encode(uri)}" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)

    recipe = nil
    if data
      params = data[0]
      recipe = self.create_recipe(params)
    end
  end

  private

  def self.create_recipe(api_params) #modifications made.
    return Recipe.new(
      api_params["uri"],
      api_params["label"],
      api_params["image"],
      api_params["url"]
      # api_params["recipe"]["id"]
      # api_params["recipe"]["calories"],
      # api_params["recipe"]["ingredients"],
    )
  end

  # def get_id(params)
  #   uri = params["recipe"]["uri"]
  #   arr_uri = uri.split(/recipe_/)
  #   id = arr_uri[1]
  #   return id
  # end
end
