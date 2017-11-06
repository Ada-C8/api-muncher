class Recipe
  attr_reader :uri, :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(uri, name, options={})
    @uri = uri.split("_")[-1]
    @name = name
    if @uri == "" || @name == ""
      raise ArgumentError
    end
    #options
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
