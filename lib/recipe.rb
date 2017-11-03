class Recipe
  attr_reader :name, :uri, :image, :orig_url, :source, :servings, :calories, :diet_labels, :health_labels, :ingredients, :nutrition, :daily

  def initialize(name, uri, image, orig_url, options = {})
    raise ArgumentError if name == nil || name == "" || uri == nil || uri == "" || image == nil || image == "" || orig_url == nil || orig_url == ""

    @name = name
    @uri = uri
    @image = image
    @orig_url = orig_url

    @source = options[:source]
    @servings = options[:servings]
    @calories = options[:calories]
    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
    @ingredients = options[:ingredients] # this is an array
    @nutrition = options[:nutrition] # a hash of hashes
    @daily = options[:daily_vals]

  end

  def calories_per_serving
    # avoid 0 division error
    if @servings == 0 || @servings == nil
      return @calories
    else
      return (@calories / @servings).round
    end
  end
end
