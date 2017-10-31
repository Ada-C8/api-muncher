class Recipe
  attr_reader :label, :url, :ingredients, :image, :source, :diet_labels, :health_labels
  def initialize(label, url, ingredients, image, source, options)
    @label = label
    @url = url
    @ingredients = ingredients
    @image = image
    @source = source
    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
  end
end
