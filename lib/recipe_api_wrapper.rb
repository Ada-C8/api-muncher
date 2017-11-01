require 'httparty'
require 'uri'


class RecipeApiWrapper  #THIS IS THE DATA
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]
  # https://api.edamam.com/search
  # ?q=chicken&app_id=814cafb4&app_key=01b4e2f096435f1272ff0588763e9be2

  def self.search(food)
    url = BASE_URL + "?q=(#{food})" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    response = HTTParty.get(url)

    # check_status(response)

    recipe_list = []
    if response["hits"]
      response["hits"].each do |raw_recipe|
        recipe_list << self.create_recipe(raw_recipe["recipe"])
      end
    end
    return recipe_list
  end


  private

  # def self.check_status(response)
  #   unless response["ok"]
  #     raise ApiError.new("API call to Edamam failed: #{response["error"]}")
  #   end
  # end

  def self.create_recipe(raw_recipe)
    return Recipe.new(
      id: raw_recipe["uri"],
      label: raw_recipe["label"],
      image: raw_recipe["image"],
      url: raw_recipe["url"],
      ingredients: raw_recipe["ingredientLines"],
      servings: raw_recipe["yield"],
      total_nutrients: raw_recipe["totalNutrients"]
    )
  end

  def self.find(id)

    url = BASE_URL + "?r=#{URI.encode(id)}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    recipe = nil

    if response
      recipe = self.create_recipe(response[0])
    end

    return recipe
  end
end
