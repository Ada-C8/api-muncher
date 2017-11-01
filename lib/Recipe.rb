class Recipe
  attr_reader :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(name, image, source, url, options={})
    @name = name
    @image = image
    @source = source
    @url = url

    @servings = options[:servings]
    @diet = options[:diet]
    @health = options[:health]
    @ingredients = options[:ingredients]
    @calories = options[:calories]
  end
end
