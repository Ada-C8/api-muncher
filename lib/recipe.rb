class Recipe
  attr_reader :id, :title, :image, :ingredients, :dietary, :link

  def initialize(id, title, image, ingredients, dietary, link)

    @id = id
    @title = title
    @image = image
    @ingredients = ingredients
    @dietary = dietary
    @link = link

  end
end

# Per instructions MUST include recipe name, link to original recipe that links in new tab (how the do this?), recipe ingredients, and the dietary information.  There must also be an image.
