class Recipe
  attr_reader :uri, :name, :link, :image, :ingredients, :healthLabels

  def initialize(uri, name, link, image, ingredients, healthLabels)
    raise ArgumentError if !valid_input?

    @uri = uri
    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @healthLabels = healthLabels
  end

    private

    def valid_input?
      return uri == nil || uri == "" name == nil || name = "" || link == nil || link == "" || image == nil || image == "" || ingredients == nil || ingredients == "" || healthLabels == nil || healthLabels == ""
    end
end
