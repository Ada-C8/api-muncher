class Recipe
  attr_reader :label, :uri, :health, :image, :ingredients, :source


  def initialize(label, uri, options = {} )
    # raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @label = label
    @uri = uri

    @health = options[:health]
    @image = options[:image]
    @ingredients = options[:ingredients]
    @source = options[:source]
  end

end
