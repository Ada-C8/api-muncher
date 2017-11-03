class ApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  API_ID = ENV["APPLICATION_ID"]
  TOKEN = ENV["EDAMAM_API_TOKEN"]

  #making custom error
  class ApiError < StandardError
  end

  def self.list_recipes(search)
    url = BASE_URL +  "?q=#{search}&app_id=#{API_ID}&app_key=#{TOKEN}"

    data = HTTParty.get(url)

    check_status(data)

    # need array to store the parsed api hash results
    recipes_list = []

    if data["hits"]
      # data["hits"] is an array of hashes, within each hash there are sub-hashes and sub-arrays, we need
      data["hits"].each do |recipe_info_hash|
        recipes_list << self.create_recipe(recipe_info_hash)
      end
    end

    puts recipes_list
    return recipes_list
  end

  private

  def self.check_status(response)
    unless response.ok?
      raise ApiError.new("API call to Edamam failed")
    end
  end


  def self.create_recipe(api_params)
    recipe = Recipe.new(

      # gets the name of the recipe
      api_params["recipe"]["label"],
      {
        original_url: api_params["recipe"]["url"],
        image: api_params["recipe"]["image"],
        ingredients: api_params["recipe"]["ingredientLines"],
        dietLabels: api_params["recipe"]["dietLabels"]
      }
    )
    return recipe
  end

end
