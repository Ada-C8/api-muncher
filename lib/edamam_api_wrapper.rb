require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  ID = ENV["EDAMAM_ID"]
  TOKEN = ENV["EDAMAM_KEY"]

  def self.search_recipes(search)
    url = BASE_URL + "?q=" + search + "&app_id=#{ID}&app_key=#{TOKEN}&to=50"
    data = HTTParty.get(url)

    if data["hits"]
      result_recipes = data["hits"].map do |recipe_hash|
        Recipe.new recipe_hash["recipe"]["uri"], recipe_hash["recipe"]["label"], recipe_hash["recipe"]["image"],
        recipe_hash["recipe"]["source"], recipe_hash["recipe"]["url"],
        recipe_hash["recipe"]["ingredientLines"], recipe_hash["recipe"]["dietLabels"],
        healthLabels: recipe_hash["recipe"]["healthLabels"]
      end
      return result_recipes
    else
      return []
    end
  end

  def self.recipe_details(uri)
    uri = uri.gsub! '#', '%23'
    url = BASE_URL + "?r=" + uri
    data = HTTParty.get(url)

    if data[0]
      result_recipes =
        Recipe.new data[0]["uri"], data[0]["label"], data[0]["image"],
        data[0]["source"], data[0]["url"],
        data[0]["ingredientLines"], data[0]["dietLabels"],
        healthLabels: data[0]["healthLabels"]

      return result_recipes
    else
      return []
    end
  end


end
