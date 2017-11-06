require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.search_recipe_results(search_term, app_id = nil, app_key = nil )
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

    r_url = BASE_URL + "search?r=#{recipe_uri}" + "&app_id=#{app_id}" + "&app_key=#{app_key}"

    #returns an array with one hash that has all the recipes's information
    response = HTTParty.get(r_url)


    #for invalid requests, Edamam sends an html 401 error response if unauthorized, or a "[]" if no recipe is found
    if response.body.include?("Error") || response.body.include?("[]")
      return false
    else
      return create_recipe(response.first)
    end

  end

end
