class Recipe
  attr_reader :name, :id, :image, :url, :diet, :ingredients, :health

  def initialize(name, uri, image, url, ingredients, options = {} )

    @name = name
    @id = create_id(uri)
    @image = image
    @url = url
    @ingredients = ingredients
    @diet = options[:diet]
    @health = options[:health]
  end

  private

  def create_id(uri)
    return uri.sub(/#/) {"%23"}
  end
end
