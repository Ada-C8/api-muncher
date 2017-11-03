require "httparty"
require "awesome_print"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  EDAMAM_ID = ENV["EDAMAM_ID"]
  EDAMAM_KEY = ENV["EDAMAM_KEY"]

  @from = 0
  @to = 100

  def self.list_recipes(search_string, app_id = nil, app_key = nil)
    app_id ||= EDAMAM_ID
    app_key ||= EDAMAM_KEY

    url = BASE_URL + "q=" + search_string + "&app_id=#{app_id}" + "&app_key=#{app_key}" + "&from=#{@from}" + "&to=#{@to}"

    # ap url

    data = HTTParty.get(url)

    # ap data

    if data["hits"]
      my_recipes = data["hits"].map do |hit|
        options = {
          ingredientLines: hit["recipe"]["ingredientLines"],
          dietLabels: hit["recipe"]["dietLabels"], image: hit["recipe"]["image"],
          source: hit["recipe"]["source"]
        }

        Recipe.new(
          hit["recipe"]["uri"],
          hit["recipe"]["label"],
          hit["recipe"]["url"],
          options
        )
      end
      return my_recipes
    else
      return [] #or return nil?
    end
  end

  def self.show_recipe(uri)
    uri = uri.gsub!(/#/, '%23')

    url = BASE_URL + "r=" + uri

    data = HTTParty.get(url)

    options = {
      ingredientLines: data[0]["ingredientLines"],
      dietLabels: data[0]["dietLabels"], image: data[0]["image"],
      source: data[0]["source"]
    }

    Recipe.new(
      data[0]["uri"],
      data[0]["label"],
      data[0]["url"],
      options
    )

  end
end
