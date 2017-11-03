require "httparty"
require "awesome_print"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  EDAMAM_ID = ENV["EDAMAM_ID"]
  EDAMAM_KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(search_string, app_id = nil, app_key = nil)
    app_id ||= EDAMAM_ID
    app_key ||= EDAMAM_KEY

    url = BASE_URL + "q=" + search_string + "&app_id=#{app_id}" + "&app_key=#{app_key}"

    # ap url

    data = HTTParty.get(url)

    # ap data

    if data["hits"]
      my_recipes = data["hits"].map do |hit|
        hash = {
          ingredientLines: hit["recipe"]["ingredientLines"],
          dietLabels: hit["recipe"]["dietLabels"], image: hit["recipe"]["image"],
          source: hit["recipe"]["source"]
        }

        Recipe.new(
          hit["recipe"]["uri"],
          hit["recipe"]["label"],
          hit["recipe"]["url"],
          hash
        )
      end
      return my_recipes
    else
      return [] #or return nil?
    end
  end
end
