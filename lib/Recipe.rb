class Recipe
  attr_reader :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(name, image, source, url, ingredients, options={})
    @name = name
    @image = image
    @source = source
    @url = url
    @ingredients = ingredients
    #optional
    @servings = options[:servings]
    @diet = options[:diet]
    @health = options[:health]
    @calories = options[:calories]
  end
end
