class Recipe

  attr_reader :uri, :name, :image, :link, :ingredients, :totalNutrients, :dietLabels, :healthLabels, :calories

  def initialize(uri, label, image, url, ingredientLines, options = {})
    @uri = URI.escape(uri)
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
