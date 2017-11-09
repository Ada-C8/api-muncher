class Recipe
  attr_reader :label, :dietLabels, :image, :url, :source, :ingredients, :uri

  def initialize(label, dietLabels, image, url, source, ingredients, uri)

    @label = label
    @dietLabels = dietLabels
    @image = image
    @url = url
    @source = source
    @ingredients = ingredients
    @uri = uri
  end
end
