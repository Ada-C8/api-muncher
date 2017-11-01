class Recipe
attr_reader :uri, :label, :image
def initialize(uri, label, image)
  raise ArgumentError if uri == nil || uri == "" 

  @uri = uri
  @label = label
  @image = image

end

end
