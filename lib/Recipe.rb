class Recipe
  attr_reader :label, :url, :ingredients, :image, :source, :diet_labels, :health_labels
  def initialize(options)
    @label = options[:label]
    @url = options[:url]
    @ingredients = options[:ingredients]
    @image = options[:image]
    @source = options[:source]
    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
  end
end
