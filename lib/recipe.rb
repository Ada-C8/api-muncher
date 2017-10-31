class Recipe
  attr_reader :name, :image, :url, :ingredients, :diet_labels, :health_labels

  def initialize(name, image, url, ingredients, options = {} )
    # raise ArgumentError if name == "" -- neccessary?

    @name = name
    @image = image
    @url = url
    @ingredients = ingredients
    # this is an array of strings

    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
  end
end
