class Recipe
  attr_reader :uri, :label, :image, :url

  def initialize(uri, label, image, url)
    raise ArgumentError if uri == nil || uri == "" || label == nil || label == "" || image == nil || image == "" || url == nil || url == ""

    @uri = uri
    @label = label
    @image = image
    @url = url
    # @id = id
    # @ingredients = ingredients
  end
end
