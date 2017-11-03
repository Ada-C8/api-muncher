require 'httparty'
require 'awesome_print'
require 'pry'

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  def self.find_number_of_recipes(keywords)
    url =  BASE_URL + "?q=" + keywords + "&app_id=#{ID}&app_key=#{KEY}"
    puts url
    results = HTTParty.get(url)
    if results
      number_of_recipes = results['count']
      puts "NUMBER OF RECIPES: #{number_of_recipes}"
      return results['count']
    else
      return 0
    end
  end

  def self.list_recipes(keywords, from, to)
    #example from API documentation:
    #https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=gte%20591,%20lte%20722&health=alcohol-free
    url = BASE_URL + "?q=" +  keywords + "&app_id=#{ID}&app_key=#{KEY}" + "&from=" + from.to_s + "&to=" + to.to_s
    puts url
    results = HTTParty.get(url)
    recipes_list = []
    if results['hits']
      # puts "RESULTS HITS******************"
      # ap results['hits']
      # i = 0
      results['hits'].each do |recipe_data|
        # puts "HERE #{i} #{create_recipe(recipe_data)}"
        recipes_list << create_recipe(recipe_data)
      end
      # puts recipes_list
      return recipes_list
    else
      return []
    end
  end

  def self.show_recipe(uri_id)
    r = "http://www.edamam.com/ontologies/edamam.ow" + uri_id
    url = BASE_URL + "?r=" + r + "&app_id=#{ID}&app_key=#{KEY}"
    puts url
    if url
      return url
    else
      return false
    end
  end

  def next
  end

  def previous
  end



  private

  def self.create_recipe(api_params)
    # puts "INSIDE AGAIN!"
    recipe = Recipe.new({
        "label" => api_params["recipe"]["label"],
        "image" => api_params["recipe"]["image"],
        "source" => api_params["recipe"]["source"],
        "url" => api_params["recipe"]["url"],
        "dietLabels" => api_params["recipe"]["dietLabels"],
        "healthLabels" => api_params["recipe"]["healthLabels"],
        "ingredientLines" => api_params["recipe"]["ingredientLines"],
        "uri" => api_params["recipe"]["uri"]
      }
    )
    # puts "A RECIPE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    # ap recipe
    return recipe
  end
end
