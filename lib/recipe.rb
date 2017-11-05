class Recipe
  attr_reader :name, :image, :url, :source,  :ingredients, :nutrition

  def initialize(name:, image:, url:, source:, ingredients:, nutrition:)
    raise ArgumentError if name == nil || source == nil || url == nil || name == "" || source == "" || url == ""

    @name = name
    @image = image
    @source = source
    @url = url
    @ingredients = ingredients
    @nutrition = nutrition
  end
end
