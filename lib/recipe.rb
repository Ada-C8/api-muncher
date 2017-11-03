class Recipe
attr_reader :uri, :label, :image, :source, :url, :yield, :ingredients, :dietlabels
def initialize(uri, label, image, source, url, yields, ingredients, dietlabels)
  raise ArgumentError if uri == nil || uri == ""

  @uri = URI.encode(uri)
  @label = label
  @image = image
  @source = source
  @url = url
  @yield = yields
  @ingredients = ingredients
  #array
  @dietlabels = dietlabels
end

end
