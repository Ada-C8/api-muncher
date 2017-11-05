class RecipeShow
  attr_reader :label, :url, :ingredients, :healthlabels, :image, :source

  def initialize(label, url, ingredients, healthlabels, image, source)
    @label = label
    @url = url
    @ingredients = ingredients
    @healthlabels = healthlabels
    @image = image
    @source = source
  end

end
