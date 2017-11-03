class Recipe
  # the hard parameters are the required bits to create an instance. The options hash is for data that is nice to have an not required
  def initialize( name, options = {} )
    raise ArgumentError if name == nil || name == ""

    @name = name

    # Options hash stuff

    @original_url = options[:original_url]
    @image = options[:image]
    @ingredients = options[:ingredients]
    @dietLabels = options[:dietLabels]

    
  end # end initialize
end
