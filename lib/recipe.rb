class Recipe
  attr_reader :id, :label, :image, :url, :ingridientLines


   def initialize( id, label, image, url, ingridientLines)
    raise ArgumentError if label == nil || label == "" || id == nil || id == ""
    @id = id
    @label = label
    @image = image
    @url = url
    @ingridientLines = ingridientLines
  end
end
