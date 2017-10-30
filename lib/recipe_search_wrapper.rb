class RecipeSearchWrapper
  ID = ENV["RECIPE_ID"]
  KEY = ENV["RECIPE_KEY"]
  BASE_URL = "https://api.edamam.com/"

  def self.search(query)
    url = BASE_URL + "search?app_id=#{ID}&app_key=#{KEY}&q=#{query}"
    response = HTTParty.get(url)['hits']
    recipes = []
    if response.empty?
      return nil
    else
      response.each do |recipe|
        recipe = recipe['recipe']
        recipes << Recipe.new(
          {
            name: recipe['label'],
            image_url: recipe['image'],
            recipe_url: recipe['url'],
            source: recipe['source'],
            ingredients: recipe['ingredientLines'],
            dietary_info: recipe['totalNutrients'],
            diet_labels: recipe['healthLabels']
          }
        )
      end
    end
    return recipes
  end
end
