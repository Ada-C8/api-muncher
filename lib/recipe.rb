class Recipe
  attr_reader :name, :original_url, :image, :ingredients, :dietLabels

  # the hard parameters are the required bits to create an instance. The options hash is for data that is nice to have an not required
  def initialize( name, original_url, ingredients, dietLabels options = {} )
    raise ArgumentError if name == nil || name == "" ||

    @name = name
    @original_url = original_url
    @ingredients = ingredients
    @dietLabels = dietLabels

    # Options hash stuff

    @image = options[:image]


  end # end initialize
end
