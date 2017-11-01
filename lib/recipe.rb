class Recipe
  attr_reader :label, :uri, :image, :source, :url, :yield, :calories, :ingredients, :healthLabels, :dietLabels,
  :totalDaily

  def initialize(label, uri, options = {})
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @label = label
    @uri = uri

    @image = options[:image]
    @url = options[:url]
    @source = options[:source]
    @yield = options[:yield]
    @calories = options[:calories]
    @ingredientLines = options[:ingredientLines]
    @dietLabels = options[:dietLabels]
    @healthLabels = options[:healthLabels]
    @totalDaily = options[:totalDaily]
  end
end
