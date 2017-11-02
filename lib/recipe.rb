class Recipe
  attr_reader :uri, :label, :image, :url, :id

  def initialize(uri, label, image, url, id)
    # raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = uri
    @label = label
    @image = image
    @uri = url
    @id = id
    # @ingredients = ingredients
  end
end
