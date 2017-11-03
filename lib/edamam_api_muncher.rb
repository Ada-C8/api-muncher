require "httparty"
# require "pry"
#
class EdamamApiMuncher
  BASE_URL = "https://api.edamam.com/search"
  RECIPE_URI_PREFIX = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  APP_ID = ENV["APP_ID"]
  API_KEY = ENV["API_KEY"]

  def self.search(query, from, to)
    url = BASE_URL + "?q=#{query}" + "&app_id=#{APP_ID}&app_key=#{API_KEY}&from=#{from}&to=#{to}"
    data = HTTParty.get(url)
    binding.pry
    recipes = []
    if data["hits"]
      data["hits"].each do |recipe|
        recipes << create_recipe(recipe["recipe"])
      end
    end
    return recipes
  end

  def self.find(id)
    url = BASE_URL + "?r=" + RECIPE_URI_PREFIX + "#{id}" + "&app_id=#{APP_ID}&app_key=#{API_KEY}"
    puts "Requesting recipe #{id}"
    puts "url is #{url}"
    data = HTTParty.get(url)
    unless data.empty?
      return create_recipe(data[0])
    else
      return nil
    end
  end

  private

  def self.create_recipe(recipe)
      return Recipe.new(
        recipe["uri"],
        recipe["label"],
        recipe["image"],
        options = {
          diet_label:  recipe["dietLabels"],
          ingredient_lines: recipe["ingredientLines"],
          url: recipe["url"]
        }
      )
  end
end
