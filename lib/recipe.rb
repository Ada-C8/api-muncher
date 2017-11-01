class Recipe
  attr_reader :label, :uri, :health, :image, :ingredients, :source


  def initialize(name, id, options = {} )
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @label = name
    @uri = id

    @health = options[:health]
    @image = options[:image]
    @ingredients = options[:ingredients]
    @source = options[:source]
  end

end
