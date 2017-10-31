class Recipe
  attr_reader :title, :id, :image, :dietlabels, :ingredients, :provider, :link


  def initialize(title, id, image, dietlabels, ingredients, provider, link)
    raise ArgumentError if title == nil || title == ""

    @title = title
    @id = id
    @image = image
    @dietlabels = dietlabels
    @ingredients = ingredients
    @provider = provider
    @link = link
  end

end
