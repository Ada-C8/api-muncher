class Recipe
  attr_reader :name, :image, :source, :url, :ingredients, :nutrition

  def initialize(name, image, source, url, ingredients, nutrition)
    raise ArgumentError if name == nil || source == nil || url == nil || name == "" || source == "" || url == ""

    @name = name
    @image = image
    @source = source
    @url = url
    @ingredients = ingredientLines
    @nutrition = totalNutrients
  end
end
