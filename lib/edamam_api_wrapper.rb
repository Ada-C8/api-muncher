require 'httparty'


class RecipeApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  ID = ENV["APP_ID"]
  KEY = ENV["EDAMAM_APP_KEY"]
  # https://api.edamam.com/search
  # ?q=chicken&app_id=814cafb4&app_key=01b4e2f096435f1272ff0588763e9be2

  def self.search(food)
    url = BASE_URL + "?q=(#{food})" + "&app_id=#{ID}" + "&app_key=#{KEY}"
    response = HTTParty.get(url)

    check_status(response)

    recipe_list = []
    if response["hits"]
      response["hits"].each do |raw_recipe|
        recipe_list << self.create_recipe(raw_recipe)
      end
    end
    return recipe_list
  end

  # def self.recipe_search(recipe)
  # end

  private

  def self.check_status(response)
    unless response["ok"]
      raise ApiError.new("API call to Edamam failed: #{response["error"]}")
    end
  end

  def self.create_recipe(raw_recipe)
    return Recipe.new(
      raw_recipe["recipe"]["label"],
      raw_recipe["recipe"]["image"],
      raw_recipe["recipe"]["url"],
      {ingredients: raw_recipe["recipe"]["ingredientLines"],
        yield: raw_recipe["recipe"]["yield"],
        total_nutrients: raw_recipe["recipe"]["totalNutrients"]}
      )
  end
  

end
