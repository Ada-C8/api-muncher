class Recipe
  attr_reader :uri, :label, :image, :source, :url, :yield, :calories, :totalWeight, :ingredients, :totalNutrients, :totalDaily, :dietLabels, :healthLabels

  def initialize(uri, options = {} )
    raise ArgumentError if uri == nil || uri == ""

    @uri = uri

    @label = options[:label]
    @image = options[:image]
    @source = options[:source]
    @url = options[:url]
    @yield = options[:yield]
    @calories = options[:calories]
    @totalWeight = options[:totalWeight]
    @ingredients = options[:ingredients]
    @totalNutrients = options[:totalNutrients]
    @totalDaily = options[:totalDaily]
    @dietLabels = options[:dietLabels]
    @healthLabels = options[:healthLabels]
  end
end
