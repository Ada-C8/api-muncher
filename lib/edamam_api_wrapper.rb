require 'httparty'
require 'awesome_print'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.item_search(item_uri, app_id=nil, app_key=nil)
    app_id ||= APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "r=#{item_uri}" "&app_id=#{app_id}" + "&app_key=#{app_key}"

    data = parsed_response(HTTParty.get(url))
    return nil if data.nil?

    if data.class != String
      recipe = Recipe.new(
        data[0]["uri"],
        data[0]["label"],
        image: data[0]["image"],
        ingredients: data[0]["ingredientLines"],
        url: data[0]["url"],
        calories: data[0]["calories"],
        healthLabels: data[0]["healthLabels"],
        digest: data[0]["digest"],
        totalNutrients: data[0]["totalNutrients"]
        )
      return recipe
    else
      return nil
    end
  end

  def self.search(term = "thanksgiving", app_id = nil, app_key = nil)

    if term == nil
      term = "Thanksgiving"
    end 

    app_id ||= APP_ID
    app_key ||= APP_KEY


    url = BASE_URL + "q=#{term}" + "&app_id=#{app_id}" + "&app_key=#{app_key}" + "&from=0" + "&to=100"

    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        Recipe.new(
        recipe_hash["recipe"]["uri"],
        recipe_hash["recipe"]["label"],
        image: recipe_hash["recipe"]["image"],
        ingredients: recipe_hash["recipe"]["ingredientLines"],
        url: recipe_hash["recipe"]["url"],
        dietaryInfo: {
          calories: recipe_hash["recipe"]["calories"],
          totalNutrients: recipe_hash["recipe"]["dietaryInfo"],
          } )
      end
    else
      return []
    end
  end

  private

  def self.parsed_response(response)
    return response.parsed_response rescue nil
  end
end
