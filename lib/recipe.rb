class Recipe
  attr_reader :label, :ingredientLines

  def initialize(label, ingredientLines)

    @label = label
    @ingredientLines = ingredientLines

  end
end
