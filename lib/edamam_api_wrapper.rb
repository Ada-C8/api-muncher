class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  BASE_URI = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  class ApiError < StandardError
  end

  def self.search(q, app_id=APP_ID, app_key=APP_KEY)
    url = BASE_URL + "?q=#{q}" + "&app_id=#{app_id}" + "&app_key=#{app_key}" +
    "&from=0" + "&to=1000"
    response = HTTParty.get(url)

    unless response.code == 200
      raise ApiError.new("Could not fulfill your request! #{response.message}")
    end

    matched_recipes = []
    if response["hits"]
      response["hits"].each do |hit_data|
        matched_recipes << create_recipe(hit_data["recipe"])
      end
    end

    return matched_recipes
  end

  def self.find_recipe(uri_id)
    url = BASE_URL + "?r=" + BASE_URI + "#{uri_id}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    data = HTTParty.get(url)

    if data.body == "[]"
      raise ArgumentError.new("Recipe does not exist!")
    else
      recipe = create_recipe(data[0])
      return recipe
    end
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["uri"],
    api_params["label"],
    api_params["source"],
    options = {
      image_url: api_params["image"],
      source_url: api_params["url"], # source url
      ingredient_lines: api_params["ingredientLines"],
      total_nutrients: api_params["totalNutrients"]
    }
  )
  end
end
