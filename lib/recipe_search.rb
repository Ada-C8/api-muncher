class RecipeSearch
  # ID = ENV["RECIPE_ID"]
  # KEY = ENV["RECIPE_KEY"]

  ID = nil
  KEY = nil

  BASE_URL = "https://api.edamam.com/"

  def self.search(query)
    url = BASE_URL + "search?app_id=#{ID}&app_key=#{KEY}&q=#{query}"
    response = HTTParty.get(url)
    # binding.pry
    unless response.code == 200
      puts "OH NO"
    end
    recipes = []
    response['hits'].each do |recipe|
      recipes << new_recipe(recipe['recipe'])
    end
    return recipes
  end

  private
  def self.new_recipe(params)
    Recipe.new(
      {
        name: params['label'],
        image_url: params['image'],
        params_url: params['url'],
        source: params['source'],
        ingredients: params['ingredientLines'],
        dietary_info: params['totalNutrients'],
        diet_labels: params['healthLabels']
      }
    )
  end
end
