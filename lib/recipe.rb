class Recipe
  attr_reader :uri, :title, :image, :ingredients, :dietary, :link

  def initialize(uri, title, image, ingredients, dietary, link)

    @uri = uri.split("_").last
    @title = title
    @image = image
    @ingredients = ingredients
    @dietary = dietary
    @link = link

  end
end
