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

end
