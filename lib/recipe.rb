class Recipe
  attr_reader :name, :id, :image, :url, :ingredients, :diet_labels, :health_labels

  def initialize(name, uri, image, url, ingredients, options = {} )
    # raise ArgumentError if name == "" -- neccessary?

    @name = name
    @id = create_id(uri)
    @image = image
    @url = url
    @ingredients = ingredients
    # this is an array of strings

    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
  end

  private

  def create_id(uri)
    return uri.sub(/#/) {"%23"}
  end
end
