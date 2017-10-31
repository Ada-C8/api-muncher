
class Recipe
  attr_reader :label, :recipe_url, :ingredients, :dietary

  def initialize(label, recipe_url, ingredients, dietary)
    # raise ArgumentError if @label == nil || name == "" || id == nil || id == ""
    #see what happens if there are no hits
    @label = label
    @recipe_url = recipe_url
    @ingredients = ingredients
    @dietary = dietary
  end


end
