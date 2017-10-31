require "httparty"

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.query(search_term)
    url = BASE_URL + "q=#{search_term}&app_id=#{APP_ID}&app_key=#{APP_KEY}"

    results = HTTParty.get(url)

    recipe_results = []
    if results["hits"]
      results["hits"].each do |recipe|
        recipe_results = create_recipe(recipe)
      end
    else
      return []
    end
    return recipe_results
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["recipe"]["label"],
    api_params["recipe"]["image"],
    api_params["recipe"]["url"],
    api_params["recipe"]["ingredientLines"],
    {
      totalNutrients: api_params["recipe"]["totalNutrients"],
      calories: api_params["recipe"]["calories"],
      healthLabels: api_params["recipe"]["healthLabels"],
      dietLabels: api_params["recipe"]["dietLabels"]
    }
    )
  end

end
