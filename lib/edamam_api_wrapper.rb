require "httparty"
require "awesome_print"

class EdamamApiWrapper
  # Your code here!
  BASE_URL = "https://api.edamam.com/"
  APP_KEY = ENV["EDAMAM_KEY"]
  APP_ID = ENV["EDAMAM_ID"]

  def self.search(query, app_key = nil, app_id = nil)
    app_key ||= APP_KEY
    app_id ||= APP_ID
    query = URI.encode(query)
    url = BASE_URL + "search?app_key=#{app_key}" + "&app_id=#{app_id}" + "&q=#{query}" + "&from=0&to=100"

    data = HTTParty.get(url)

    if data["hits"] && data["hits"].count > 0
      recipes = data["hits"].map do |recipe_hash|
        Recipe.new(
          name: recipe_hash["recipe"]["label"],
          id: recipe_hash["recipe"]["uri"].remove("http://www.edamam.com/ontologies/edamam.owl#recipe_"),
          url: recipe_hash["recipe"]["url"],
          ingredients: recipe_hash["recipe"]["ingredientLines"],
          # optional values
          dietary_info: recipe_hash["recipe"]["dietLabels"],
          health_info: recipe_hash["recipe"]["healthLabels"],
          image: recipe_hash["recipe"]["image"],
          source: recipe_hash["recipe"]["source"],
          yield:recipe_hash["recipe"]["yield"])
      end
      return recipes
    else
      return[]
    end
  end

end
