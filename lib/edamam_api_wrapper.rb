require 'httparty'
require 'awesome_print'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["EDAMAM_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.item_search(item_uri, app_id=nil, app_key=nil)
    app_id ||= APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "r=#{item_uri}" "&app_id=#{app_id}" + "&app_key=#{app_key}"

    data = parsed_response(HTTParty.get(url))
    return nil if data.nil?

    if data.class != String
      recipe = EdamamApiWrapper.make_recipe(data[0])
    else
      return nil
    end
  end

  def self.search(term="Thanksgiving", app_id = nil, app_key = nil)

    app_id ||= APP_ID
    app_key ||= APP_KEY


    url = BASE_URL + "q=#{term}" + "&app_id=#{app_id}" + "&app_key=#{app_key}" + "&from=0" + "&to=5"

    data = HTTParty.get(url)

    if data["hits"]
      my_recipes = data["hits"].map do |recipe_hash|
        EdamamApiWrapper.make_recipe(recipe_hash["recipe"])
      end
    else
      return []
    end
  end

  private

  def self.make_recipe(rec_hash)
    recipe = Recipe.new(
      rec_hash["uri"],
      rec_hash["label"],
      image: rec_hash["image"],
      ingredients: rec_hash["ingredientLines"],
      url: rec_hash["url"],
      calories: rec_hash["calories"],
      healthLabels: rec_hash["healthLabels"],
      digest: rec_hash["digest"],
      totalNutrients: rec_hash["totalNutrients"]
    )
    return recipe
  end

  def self.parsed_response(response)
    return response.parsed_response rescue nil
  end
end
