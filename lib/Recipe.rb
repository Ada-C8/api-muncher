class Recipe
  attr_reader :uri, :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(uri)#, name, image, source, url, ingredients, options={})
    @uri = uri.split("_")[-1]
    # @name = name
    # @image = image
    # @source = source
    # @url = url
    # @ingredients = ingredients
    # #optional
    # @servings = options[:servings]
    # @diet = options[:diet]
    # @health = options[:health]
    # @calories = options[:calories]
  end
end
