class Recipe
  attr_reader :uri, :label, :image, :url, :ingredients, :diet_labels

  def initialize(uri, label, image, url,ingredients, diet_labels)
    raise ArgumentError if uri == nil || uri == "" || label == nil || label == ""

    @uri = uri
    @label = label
    @image = image
    @url = url
    @ingredients = ingredients
    @diet_labels = diet_labels
  end
end
