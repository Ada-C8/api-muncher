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

    unless response.code == 200 # This is for the app id and app key
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

# %23 https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2&app_id=d2fbdaf7&app_key=6e7b5b6faead1b3deffb7fe4416542c2

# http:%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2"

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


  # Params: ID Weird edamam id number
  # Passing to API route and cannot use the entire url
  # then you would shorten it
  # And then use another key to reconstruct it
  private

  # TODO: Continue to create new instance of a recipe
  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["uri"],
    api_params["label"],
    api_params["image"],
    api_params["source"],
    api_params["url"],
    api_params["ingredientLines"],
  )
  end
end

# Wrap HTTP Party in a class and then call it in the controller
