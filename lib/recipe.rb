class Recipe
  attr_reader :label, :uri, :image, :source, :url, :yield, :calories, :ingredientLines, :healthLabels, :dietLabels,
  :totalDaily

  def initialize(label, uri, options = {})
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @label = label
    @uri = uri.split('_')[-1]
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
