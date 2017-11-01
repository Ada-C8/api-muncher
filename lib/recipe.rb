class Recipe
  attr_reader :uri, :label, :image, :url, :ingridientLines


  def initialize(uri, label, image, url, ingridientLines)
    #raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = uri
    @label = label
    @image = image
    @url = url
    @ingridientLines = ingridientLines
  end
end
