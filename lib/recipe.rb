
class Recipe
  attr_reader :name, :image, :id, :url, :ingredients, :servings, :total_nutrients

  def initialize(name:, image:, id:, url:, ingredients:, servings:, total_nutrients:)
    raise ArgumentError if name == nil || name == ""
    @name = name
    @image = image
    @id = id
    @url = url
    @ingredients = ingredients
    @servings = servings # yield is how it is referred to in edamam
    @total_nutrients = total_nutrients   # how it is displayed in the dev docs totalNutrients
  end
end
