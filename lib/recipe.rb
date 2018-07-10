class Recipe
  attr_reader :label, :uri, :image

  def initialize(label, uri, image)
    @label = label
    @uri = uri
    @image = image
  end

end
