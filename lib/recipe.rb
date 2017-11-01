class Recipe
  attr_reader :name, :image, :source, :url, :ingredients, :nutrition

  def initialize(label, image, source, url, ingredientLines, totalNutrients)
    raise ArgumentError if name == nil || source == nil || url == nil || name == "" || source == "" || url == ""

    @name = label
    @image = image
    @source = source
    @url = url
    @ingredients = ingredientLines
    @nutrition = totalNutrients
  end
end
