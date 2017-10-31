class Recipe
  attr_reader :id, :name, :image, :ingredients, :healthLabels

  def initialize(id, name, image, ingredients)
    raise ArgumentError if !valid_input?

    @id = id
    @name = name
    @image = image
    @ingredients = ingredients
    @healthLabels = healthLabels

    private

    def valid_input?
      return name == nil || name = "" || id == nil || id == "" || image == nil || image == "" || ingredients == nil || ingredients == "" || healthLabels == nil || healthLabels == ""
    end
end
