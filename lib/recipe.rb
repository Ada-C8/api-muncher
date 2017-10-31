class Recipe
  attr_reader :label, :uri, :image, :source, :url, :yield, :calories, :ingredients, :healthLabels, :totalDaily

  def initialize(label, uri, options = {})
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @label = label
    @uri = uri

    @image = options["image"]
    @url = options['url']
    @source = options['source']
    @yield = options['yield']
    @calories = options['calories']
    @ingredients = options['ingredients']
    @healthLabels = options['healthLabels']
    @totalDaily = options['totalDaily']
  end
end
