require "httparty"

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.query(search_term, app_id = nil, app_key = nil)
    app_id ||= APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "q=#{search_term}&app_id=#{app_id}&app_key=#{app_key}&from=0&to=100"

    results = HTTParty.get(url)

    recipe_results = []
    if results["hits"]
      results["hits"].each do |recipe|
        recipe_results << create_recipe(recipe)
      end
    else
      return []
    end
    return recipe_results
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["recipe"]["uri"],
    api_params["recipe"]["label"],
    api_params["recipe"]["image"],
    api_params["recipe"]["url"],
    api_params["recipe"]["yield"],
    api_params["recipe"]["ingredientLines"],
    {
      totalNutrients: api_params["recipe"]["totalNutrients"],
      calories: api_params["recipe"]["calories"],
      healthLabels: api_params["recipe"]["healthLabels"],
      dietLabels: api_params["recipe"]["dietLabels"]
    }
    )
  end

  def self.find_recipe(uri, api_id = nil, app_key = nil)
    app_id ||= APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "r=#{uri}&app_id=#{app_id}&app_key=#{app_key}"
    result = HTTParty.get(url)
    if result && result[0]
    recipe = Recipe.new(
    result[0]["uri"],
    result[0]["label"],
    result[0]["image"],
    result[0]["url"],
    result[0]["yield"],
    result[0]["ingredientLines"],
    {
      totalNutrients: result[0]["totalNutrients"],
      calories: result[0]["calories"],
      healthLabels: result[0]["healthLabels"],
      dietLabels: result[0]["dietLabels"]
    }
    )
  end
  end

end
