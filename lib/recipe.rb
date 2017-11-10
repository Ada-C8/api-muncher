class Recipe
  attr_reader :id, :label, :image, :url, :ingredientLines, :dietLabels
  def initialize( id, label, image, url, ingredientLines, dietLabels)
    raise ArgumentError if label == nil || label == "" || id == nil || id == ""
    @id = id
    @label = label
    @image = image
    @url = url
    @ingredientLines = ingredientLines
    @dietLabels = dietLabels
  end
end
