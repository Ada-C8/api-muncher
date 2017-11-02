require "httparty"
# require "pry"
#
class EdamamApiMuncher
  BASE_URL = "https://api.edamam.com/search?q="
  APP_ID = ENV["APP_ID"]
  API_KEY = ENV["API_KEY"]

  def self.search(query, from, to)
    url = BASE_URL + query + "&app_id=#{APP_ID}&app_key=#{API_KEY}&from=#{from}&to=#{to}"
    data = HTTParty.get(url)

    recipe_list = []
    data["hits"].each do |recipe|
      recipe_list << create_recipe(recipe["recipe"])
    end
    return recipe_list
  end

  private

  def self.create_recipe(recipe)
      return Recipe.new(
        recipe["uri"],
        recipe["label"],
        recipe
      )
    end
end
