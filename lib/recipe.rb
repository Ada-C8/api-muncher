class Recipe
  attr_reader :uri, :label, :image, :url, :calories, :ingredients

  def initialize(uri, label, image, uri, calories, ingredients )
    # raise ArgumentError if name == nil || name == "" || uri == nil || uri == ""

    @uri = uri
    @label = label
    @image = image
    @uri = url
    @calories = calories
    @ingredients = ingredients
  end
end
