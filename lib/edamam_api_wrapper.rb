require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search_recipe_results(search_term, app_id = nil, app_key = nil )
  # if q
  #TODO: search terms with spaces
    app_id ||= APP_ID
    app_key ||= APP_KEY

    q_url = BASE_URL + "search?q=#{search_term}" + "&app_id=#{app_id}" + "&app_key=#{app_key}"+"&from=0&to=100"

    # encoded_uri = URI.encode(q_url)
    response = HTTParty.get(q_url)

    recipe_results = []

    if response["hits"]
      response["hits"].each do |recipe_params|
        # recipe_results << create_recipe(recipe_params)
        recipe_results << create_recipe(recipe_params["recipe"])


      end
    end

    return recipe_results

  end

  private

  def self.create_recipe(api_params)
    # return Recipe.new(
    #   api_params["recipe"]["label"],
    #   api_params["recipe"]["url"],
    #   api_params["recipe"]["uri"],
    #   api_params["recipe"]["image"],
    #   api_params["recipe"]["yield"],
    #   api_params["recipe"]["ingredientLines"],
    #   api_params["recipe"]["dietLabels"],
    #     {
    #       health_labels: api_params["recipe"]["healthLabels"],
    #       cautions: api_params["recipe"]["cautions"],
    #       calories: api_params["recipe"]["calories"],
    #       total_nutrients: api_params["recipe"]["totalNutrients"],
    #       total_daily: api_params["recipe"]["totalDaily"],
    #       digest: api_params["recipe"]["digest"]
    #     }
    # )

    return Recipe.new(
      api_params["label"],
      api_params["url"],
      api_params["uri"],
      api_params["source"],
      api_params["image"],
      api_params["yield"],
      api_params["ingredientLines"],
      api_params["dietLabels"],
        {
          health_labels: api_params["healthLabels"],
          cautions: api_params["cautions"],
          calories: api_params["calories"],
          total_nutrients: api_params["totalNutrients"],
          total_daily: api_params["totalDaily"],
          digest: api_params["digest"]
        }
    )
  end

  def self.find_recipe(recipe_uri, app_id = nil, app_key = nil)
    app_id ||= APP_ID
    app_key ||= APP_KEY

    r_url = BASE_URL + "search?r=#{recipe_uri}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    #use URI
    response = HTTParty.get(r_url)

    #returns an array with one hash that has all the recipes's information

    #no "hits key", no "recipe" key
    #keys are just the recipe properties, like "uri", "label", etc.
    if response.count > 0
      # return the recipe
      #refactor, create_recipe uses params["recipe"]["<key>"], and this response has no "recipe" key
      return create_recipe(response.first)
    else
      return []
    end

  end

end
