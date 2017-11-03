class Recipe
  attr_reader :name, :id, :image_url, :url, :servings, :ingredients, :calories

  def initialize(name:, id:, url:, ingredients:, image_url:, **options)
    # raise ArgumentError if name == nil
    @name = name
    @id = id
    @url = url
    @ingredients = ingredients
    @image_url = image_url

    @servings = options[:servings]
    @calories = options[:calories]
    @total_nutrients = options[:total_nutrients]
    @health_labels = options[:health_labels]
    @diet_labels = options[:diet_labels]
  end
end
