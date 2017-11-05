require "httparty"
require 'pry'

class MuncherApiWrapper
  BASE_URL = "https://api.edamam.com/"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["EDAMAM_ID"]

  class ApiError < StandardError
  end

  def self.search(search_term, from = 0, id=ID)
    url = BASE_URL + "search?q=" + search_term + "&app_id=#{id}" + "&app_key=#{KEY}" + "&from=#{from}"
    puts "about to send request for recipes"
    data = HTTParty.get(url)
    puts "got response"
    puts " status: #{data.code}: #{data.message}"
    puts "parsed_response is #{data.parsed_response}"
    unless data["ok"]
      raise ApiError.new("Call to list recipes failed")
    end
    recipes_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipes_list << create_recipe(recipe_data["recipe"])
      end
    end
    return recipes_list
  end

  def self.show(uri)
    encoded_uri = URI.encode(uri)
    url = BASE_URL + "search?r=#{encoded_uri}" #+ uri + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    return create_recipe(data[0])
    #where what is returned just for one, how to access??
  end


  private

    def self.create_recipe(recipe_params)
      return Recipe.new(
        recipe_params["label"],
        recipe_params["uri"],
        {
          image: recipe_params["image"],
          ingredients: recipe_params["ingredientLines"],
          health: recipe_params["healthLabels"],
          source: recipe_params["source"]

        }
      )
    end


end
