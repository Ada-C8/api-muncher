class Recipe
  attr_reader :name, :image, :uri, :url, :source,  :ingredients, :nutrition

  def initialize(name, image, uri, options = {})
    raise ArgumentError if name == nil || image == nil || uri == nil || name == "" || image == "" || uri == ""

    @name = name
    @image = image
    @uri = uri
    # optional variables

    @source = options[:source]
    @url = options[:url]
    @ingredients = options[:ingredients]
    @nutrition = options[:nutrition]
  end
end
