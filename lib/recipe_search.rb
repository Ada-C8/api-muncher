# :nodoc:
class RecipeSearch
  ID = ENV['RECIPE_ID']
  KEY = ENV['RECIPE_KEY']

  BASE_URL = 'https://api.edamam.com/'

  def self.search(query)
    url = BASE_URL + "search?app_id=#{ID}&app_key=#{KEY}&q=#{query}"
    response = HTTParty.get(url)

    raise(APIError, response.message) unless response.code == 200

    recipes = []
    response['hits'].each do |recipe|
      recipes << new_recipe(recipe['recipe'])
    end

    recipes
  end

  def self.find(uri)
    url = BASE_URL + "search?app_id=#{ID}&app_key=#{KEY}&r=#{URI.encode(uri)}"
    response = HTTParty.get(url)

    raise(APIError, response.message) if response.empty?

    new_recipe(response[0])
  end

  def self.new_recipe(params)
    Recipe.new(
      name: params['label'],
      image_url: params['image'],
      recipe_url: params['url'],
      source: params['source'],
      ingredients: params['ingredientLines'],
      dietary_info: params['totalNutrients'],
      diet_labels: params['healthLabels']
    )
  end

  class APIError < RuntimeError; end
end
