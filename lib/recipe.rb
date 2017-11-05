class Recipe

  attr_reader :uri, :name, :image, :ingredients, :dietaryInfo, :url, :calories, :totalNutrients

  def initialize(uri, name, options = {})
    raise ArgumentError if name == nil || name == "" || uri == nil || uri == ""

    @uri = URI.escape(uri)
    @name = name
    @image = options[:image]
    @ingredients = options[:ingredients]
    @url = options[:url]
    @calories = options[:calories]
    @totalNutrients = options[:totalNutrients]
    @healthLabels = options[:healthLabels]
    @digest = options[:digest]
  end

end
