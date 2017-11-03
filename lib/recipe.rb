class Recipe
  attr_reader :name, :original_url, :image, :ingredientsLine, :dietLabels, :image

  # the hard parameters are the required bits to create an instance. The options hash is for data that is nice to have an not required
  def initialize( name, original_url, ingredientsLine, dietLabels, options = {} )
    raise ArgumentError if name == nil || name == "" || original_url == nil || original_url == "" || ingredientsLine == nil || ingredientsLine == "" || dietLabels == nil || dietLabels == ""

    @name = name # name is a string
    @original_url = original_url # original_url is a string
    @ingredientsLine = ingredientsLine # ingredientsLine is array of strings
    @dietLabels = dietLabels # dietLabels is an array of strings

    # Options hash stuff

    @image = options[:image] # image is a url in string format


  end # end initialize
end
