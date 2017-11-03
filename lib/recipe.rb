class Recipe
  attr_reader :uri, :label, :image, :url

  def initialize(uri, label, image, url)
    # raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = uri
    @label = label
    @image = image
    @url = url
    # @id = id
    # @ingredients = ingredients
  end
end
