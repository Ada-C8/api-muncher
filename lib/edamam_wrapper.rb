require "httparty"

class EdamamWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  ID = ENV["API_ID"]
  KEY = ENV["API_KEY"]


  # def initialize(response)

  def self.list_recipes(word)
    url = BASE_URL + word + "id=#{ID}" + "key=#{KEY}"
    puts url
    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |hit|
        hit.each do |recipe|
          recipe_list << create_recipe(recipe)
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
        api_params["recipe"]["calories"],
        api_params["recipe"]["ingredients"],
      )
    end
  end
end
