class RecipeShow
  attr_reader :label, :url, :ingredients, :healthlabels, :image

  def initialize(label, url, ingredients, healthlabels, image)
    @label = label
    @url = url
    @ingredients = ingredients
    @healthlabels = healthlabels
    @image = image
  end

end
