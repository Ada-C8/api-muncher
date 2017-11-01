require 'httparty'
require 'awesome_print'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?q="
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(keywords)
    #example from API documentation:
    #https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=gte%20591,%20lte%20722&health=alcohol-free
    url = BASE_URL + keywords + "&app_id=#{ID}&app_key=#{KEY}"
    puts url
    results = HTTParty.get(url)
    puts "RESULTS******************"
    ap results
    puts "RESULTS******************"
    
    recipes_list = []
    if results['hits']
      results['hits'].each do |recipe_data|
        recipes_list << create_recipe(recipe_data)
      end
      return recipes_list
    else
      return []
    end
  end

  # def self.number_of_recipes(keywords)
  # end

  private

  def self.create_recipe(api_params)
    recipe = Recipe.new({
        uri: api_params["recipe"]["uri"],
        label: api_params["recipe"]["label"],
        image: api_params["recipe"]["image"],
        source: api_params["recipe"]["source"],
        url: api_params["recipe"]["url"],
        dietLabels: api_params["recipe"]["dietLabels"],
        healthLabels: api_params["recipe"]["healthLabels"],
        ingredientLines: api_params["recipe"]["ingredientLines"],
      }
    )
    return recipe
  end
end
