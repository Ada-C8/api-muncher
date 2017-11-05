class Recipe
  attr_reader :name, :uri, :image, :url, :servings, :ingredients, :calories

  def initialize(name:, uri:, url:, ingredients:, image:, **options)
    # raise ArgumentError if name == nil
    @name = name
    @uri = uri #URI.encode(uri)
    @url = url
    @ingredients = ingredients
    @image = image

    @servings = options[:servings]
    @calories = options[:calories]
    @total_nutrients = options[:total_nutrients]
    @health_labels = options[:health_labels]
    @diet_labels = options[:diet_labels]
  end
end
