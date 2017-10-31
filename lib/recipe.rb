class Recipe
  attr_reader :label, :url, :image

  def initialize(label, url, image, ingredients, options = {} )
    raise ArgumentError if label == nil || label == "" || url == nil || url == "" || image == nil || image == "" || ingredients == nil || ingredients == ""

    @label = label
    @url = url
    @image = image
    @ingredients = ingredients
  end

  def ingredients_formatted
    ingredients_list = []
    @ingredients.each do |ingred|
      ingredients_list << ingred["text"]
    end
    return ingredients_list
  end
end
