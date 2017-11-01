require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search_recipe_results(search_term)
  # if q
    q_url = BASE_URL + "search?q=#{search_term}" + "&app_id= #{APP_ID}" + "&app_key=#{APP_KEY}"

  # if r
    r_url = BASE_URL + "search?r=#{@uri}" + "&app_id= #{APP_ID}" + "&app_key=#{APP_KEY}"
    #use URI

    response = HTTParty.get(q_url)
    response = HTTParty.get(r_url)

    recipe_results = []

    if response["hits"]
      response["hits"].each do |recipe|
        recipe_results << create_recipe(recipe)
      end
    else
      return []
    end

  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["recipe"]["label"],
      api_params["recipe"]["url"],
      api_params["recipe"]["uri"],
      api_params["recipe"]["image"],
      api_params["recipe"]["yield"],
      api_params["recipe"]["ingredientLines"],
      api_params["recipe"]["dietLabels"],
        {
          health_labels: api_params["recipe"]["healthLabels"],
          cautions: api_params["recipe"]["cautions"],
          calories: api_params["recipes"]["calories"],
          total_nutrients: api_params["recipes"]["totalNutrients"],
          total_daily: api_params["recipes"]["totalDaily"],
          digest: api_params["recipes"]["digest"]
        }
    )

  end

end
