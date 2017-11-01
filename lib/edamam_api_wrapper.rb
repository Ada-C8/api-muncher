require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search_recipe_results(search_term)
  # if q
  #TODO: search terms with spaces
    q_url = BASE_URL + "search?q=#{search_term}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    p q_url

    # encoded_uri = URI.encode(q_url)
    response = HTTParty.get(q_url)

    recipe_results = []

    if response["hits"]
      response["hits"].each do |recipe|
        recipe_results << create_recipe(recipe)
      end
    end

    return recipe_results

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
          calories: api_params["recipe"]["calories"],
          total_nutrients: api_params["recipe"]["totalNutrients"],
          total_daily: api_params["recipe"]["totalDaily"],
          digest: api_params["recipe"]["digest"]
        }
    )

  end

  def self.find_recipe(recipe)
    r_url = BASE_URL + "search?r=#{recipe.uri}" + "&app_id= #{APP_ID}" + "&app_key=#{APP_KEY}"
    #use URI
    response = HTTParty.get(r_url)
    if response["hits"]
      # return the recipe
    else
      # return []
    end

  end

end
