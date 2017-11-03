class Recipe
  attr_reader :id, :label, :image, :url, :ingridientLines, :uri


   def initialize( id, label, image, url, ingridientLines)
    #raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""
    #@id = uri
    #@id = uri.last(32)
    @id = id
    @label = label
    @image = image
    @url = url
    @ingridientLines = ingridientLines
  end
end
