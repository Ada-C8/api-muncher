class Recipe
  attr_reader :label, :image, :uri, :url

  def initialize(label, image, uri, url)
    raise ArgumentError if label == nil || label == ""
    @label = label
    @image = image
    @uri = uri
    @url = url
  end
end
