class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  EDAMAM_KEY = ENV["EDAMAM_KEY"]
  EDAMAM_ID = ENV["EDAMAM_ID"]

  class ApiError < StandardError
  end

  def self.list_recipes(search_term)
    url = BASE_URL + search_term + "app_id=$" + EDAMAM_ID + "&app_key=$" + EDAMAM_KEY

    data = HTTParty.get(url)

    recipe_list = []

    if data["hits"]
      data["hits"].each do |result|
        recipe_list << self.get_recipe(search_term)
      end
    end

    return recipe_list
  end

  private
  def self.get_recipe(api_params)
    return Recipe.new(
      api_params["label"],
      api_params["uri"])
  end
end
