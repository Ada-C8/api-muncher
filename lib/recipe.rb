class Recipe
  attr_reader :name, :link, :image, :ingredients, :healthLabels

  def initialize(name, link, image, ingredients)
    raise ArgumentError if !valid_input?

    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @healthLabels = healthLabels

    private

    def valid_input?
      return name == nil || name = "" || link == nil || link == "" || image == nil || image == "" || ingredients == nil || ingredients == "" || healthLabels == nil || healthLabels == ""
    end
end
