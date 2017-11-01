class Recipe
  attr_reader :name, :url, :image, :source, :servings, :calories, :diet_labels, :health_labels, :ingredients, :nutrition
  
  def initialize(name, url, image, options = {})
    raise ArgumentError if name == nil || name == "" || url == nil || url == "" || image == nil || image == ""

    @name = name
    @url = url
    @image = image

    @source = options[:source]
    @servings = options[:servings]
    @calories = options[:calories]
    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
    @ingredients = options[:ingredients] # this is an array
    @nutrition = options[:nutrition] # a hash of hashes

  end
end
