class Recipe
  attr_reader :name, :uri, :image, :url, :servings, :ingredients, :ingredient_lines, :calories, :total_nutrients, :health_labels, :diet_labels

  def initialize(name:, uri:, image:, **options)
    # raise ArgumentError if name == nil
    @name = name
    @uri = uri #URI.encode(uri)
    @image = image
    
    @url = options[:url]
    @ingredients = options[:ingredients]
    @ingredient_lines = options[:ingredient_lines]
    @servings = options[:servings]
    @calories = options[:calories]
    @total_nutrients = options[:total_nutrients]
    @health_labels = options[:health_labels]
    @diet_labels = options[:diet_labels]
  end
end
