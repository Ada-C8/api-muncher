require 'httparty'
require 'uri'


class RecipeApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  class ApiError < StandardError
  end

  def self.search(food, from, app_id=APP_ID)
    url = BASE_URL + "?q=#{food}" + "&from=#{from}" + "&app_id=#{app_id}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    check_status(response)

    recipe_list = []
    if response["hits"]
      response["hits"].each do |raw_recipe|
        recipe_list << self.create_recipe(raw_recipe["recipe"])
      end
    end

    return recipe_list
  end

  def self.find(id)
    url = BASE_URL + "?r=#{URI.encode(id)}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    check_status(response)

    recipe = nil

    if response 
      recipe = self.create_recipe(response[0])
    end

    return recipe
  end

  private

  def self.create_recipe(raw_recipe)
    return Recipe.new(
    raw_recipe["uri"],
    raw_recipe["label"],
    raw_recipe["image"],
    raw_recipe["url"],
    raw_recipe["ingredientLines"],
    raw_recipe["yield"],
    {
      source: raw_recipe["source"],
      health_labels: raw_recipe["healthLabels"],
      calories: raw_recipe["calories"],
      fat: raw_recipe["totalNutrients"]["FAT"],
      carbs: raw_recipe["totalNutrients"]["CHOCDF"],
      protein: raw_recipe["totalNutrients"]["PROCNT"]
    }
    )
  end

  def self.check_status(response)
    # puts response.code
    # puts "response ok? #{response["ok"]}"
    # puts "response .ok? #{response.ok?}"
    unless response.ok?
      raise ApiError.new("API call to Edamam failed")
    end

    if response == []
      raise ApiError.new("API call to Edamam failed")

    end
  end

end
