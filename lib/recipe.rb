class Recipe
  attr_reader :label, :uri, :health, :image, :ingredients, :source


  def initialize(label, uri, options = {} )
     raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @label = label
    @uri = uri

    @health = options[:health]
    @image = options[:image]
    @ingredients = options[:ingredients]
    @source = options[:source]
  end

end
