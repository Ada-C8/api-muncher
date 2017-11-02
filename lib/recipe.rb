class Recipe

  attr_reader :uri, :name, :image, :link, :servings, :ingredients, :totalNutrients, :dietLabels, :healthLabels, :calories

  def initialize(uri, label, image, url, servings, ingredientLines, options = {})
    @uri = URI.escape(uri)
    @name = label
    @image = image
    @link = url
    @servings = servings
    @ingredients = ingredientLines
    @totalNutrients = options[:totalNutrients]
    @dietLabels = options[:dietLabels]
    @healthLabels = options[:healthLabels]
    @calories = options[:calories]
  end

end
