class Recipe
  attr_reader :label, :image, :uri, :url, :ingredients, :nutrition

  def initialize(label, image, options = {})
    raise ArgumentError if label == nil || label == ""
    @label = label
    @image = image
    @uri = options[:uri]
    @url = options[:url]
    @ingredients = options[:ingredients]
    @nutrition= options[:nutrition]
  end
  # def initialize(label, image, uri, url)
  #   raise ArgumentError if label == nil || label == ""
  #   @label = label
  #   @image = image
  #   @uri = uri
  #   @url = url
  # end
end
