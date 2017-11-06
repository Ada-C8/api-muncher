
class Recipe
  attr_reader :name, :image, :id, :url, :ingredients, :servings, :source, :health_labels, :calories, :fat, :carbs, :protein 

  def initialize(id, name, image, url, ingredients, servings, options = {})
    raise ArgumentError if name == nil || name == ""
    @name = name
    @image = image
    @id = id
    @url = url
    @ingredients = ingredients
    @servings = servings # yield is how it is referred to in edamam

    @source = options[:source]
    @health_labels = options[:health_labels]
    @calories = options[:calories]
    @fat = options[:fat]
    @carbs = options[:carbs]
    @protein = options[:protein]   # how it is displayed in the dev docs totalNutrients
  end
end
