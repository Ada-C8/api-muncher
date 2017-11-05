class Recipe
  attr_reader :uri, :name, :source, :link, :image, :ingredients, :healthLabels

  def initialize(uri, name, source, link, image, ingredients, healthLabels)
    raise ArgumentError if !valid_input?

    @uri = uri
    @name = name
    @source = source
    @link = link
    @image = image
    @ingredients = ingredients
    @healthLabels = healthLabels
  end

  def id
    return uri.split("_")[1]
  end

    private


    def valid_input?
      return uri == nil || uri == "" || name == nil || name = "" || source == nil || source == "" || link == nil || link == "" || image == nil || image == "" || ingredients == nil || ingredients == "" || healthLabels == nil || healthLabels == ""
    end
end
