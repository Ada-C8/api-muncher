class Recipe

  attr_reader :name, :image, :link, :ingredients, :totalNutrients, :dietLabels, :healthLabels, :calories

  def initialize(label, image, url, ingredientLines, options = {})
    @name = label
    @image = image
    @link = url
    @ingredients = ingredientLines
    @totalNutrients = options[:totalNutrients]
    @dietLabels = options[:dietLabels]
    @healthLabels = options[:healthLabels]
    @calories = options[:calories]
  end

end
