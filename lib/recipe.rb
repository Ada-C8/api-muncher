class Recipe
  # the hard parameters are the required bits to create an instance. The options hash is for data that is nice to have an not required
  def initialize( name, options = {} )
    raise ArgumentError if name == nil || name == ""

    @name = name

    # Options hash stuff

    @original_url = options[:original_url]
    @image = options[:image]
    @ingredients = options[:ingredients]

    {
      original_url: api_params["recipe"]["url"],
      image: api_params["recipe"]["image"],
      ingredients: api_params["recipe"]["ingredientLines"],
      dietLabels: api_params["recipes"]["dietLabels"]
    }
  end # end initialize
end
