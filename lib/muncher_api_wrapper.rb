require 'HTTParty'

class MuncherApiWrapper
  BASE_URL = "https://test-es.edamam.com/search?q="
  ID = ENV["EDAMAN_ID"]
  KEY = ENV["EDAMAN_KEY"]

  def self.find_recipes(word)
    url = BASE_URL + word + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_array|
        recipe_list << create_recipe(recipe_array)
      end
    end
    return recipe_list
  end

  private
  def self.create_recipe(api_params)
    return Recipe.new(
    api_params["recipe"]["uri"],
    api_params["recipe"]["label"],
    api_params["recipe"]["image"],
    api_params["recipe"]["url"],
    api_params["recipe"]["ingridientLines"]
    #TODO poner algo de dietary information api_params["recipe"]["uri"],
    )
  end
end
