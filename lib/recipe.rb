

class Recipe
  attr_reader :id, :name, :url, :image, :ingredientsLine, :dietLabels, :uri, :source, :image

  # the hard parameters are the required bits to create an instance. The options hash is for data that is nice to have an not required
  def initialize( name, url, ingredientsLine, dietLabels, uri, source, options = {} )
    raise ArgumentError if name == nil || name == "" || url == nil || url == "" || ingredientsLine == nil || ingredientsLine == "" || dietLabels == nil || dietLabels == ""

    @id = create_id(uri)
    @name = name # name is a string
    @url = url # url is a string
    @ingredientsLine = ingredientsLine # ingredientsLine is array of strings
    @dietLabels = dietLabels # dietLabels is an array of strings
    @uri = uri
    @source = source

    # Options hash stuff
    @image = options[:image] # image is a url in string format


  end # end initialize

  private


  def create_id(uri)
    uri = URI.encode(uri, /\W/)
    return uri
  end



end
