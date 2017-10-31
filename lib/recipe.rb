class Recipe
  attr_reader :label, :uri, :image, :source, :url, :yield, :calories, :health_labels, :diet_labels, :ingredients, :dietary_info

  def initialize(label, uri, options = {})

    raise ArgumentError if label.nil? || label.empty? || uri.nil? || uri.empty?
    @label = label
    @uri = uri

    @image = options[:image]
    @source = options[:source]
    @url = options[:url]
    @yield = options[:yield]
    @calories = options[:calories]
    @health_labels = options[:labels]
    @diet_labels = options[:diets]
    @ingredients = options[:ingredients]
    @dietary_info = options[:dietary]
  end

end
