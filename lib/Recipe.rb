class Recipe
  attr_reader :uri, :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(uri, name, options={})
    @uri = uri
    @name = name
    if @uri == "" || @name == ""
      raise ArgumentError
    end
    #additional arguments
    @image = options[:image]
    @source = options[:source]
    @url = options[:url]
    @ingredients = options[:ingredients]
    @servings = options[:servings]
    @diet = options[:diet]
    @health = options[:health]
    @calories = options[:calories]
  end
end
