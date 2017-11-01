class Recipe
  attr_reader :label, :ingredientLines, :image, :url, :source, :ingredients, :uri

  def initialize(label, ingredientLines, image, url, source, ingredients, uri)

    @label = label
    @ingredientLines = ingredientLines
    @image = image
    @url = url
    @source = source
    @ingredients = ingredients
    @uri = uri
  end
end





# pagination
#list of recipes for a given search term, ten at a time

# This view shall show the name of the recipe and the corresponding photo

# The view shall have a link from the recipe to a recipe show view
