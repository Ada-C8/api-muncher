class RecipeShow
  attr_reader :label, :orig_recipe, :ingredients, :digest

  def initialize(label, orig_recipe, ingredients, digest)
    @label = label
    @orig_recipe = orig_recipe
    @ingredients = ingredients
    @digest = digest
  end

end
