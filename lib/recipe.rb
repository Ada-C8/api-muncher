class Recipe
  attr_reader :label, :url, :uri, :image

  def initialize(label, url, uri, image, ingredients, options = {} )
    raise ArgumentError if label == nil || label == "" || url == nil || url == "" || image == nil || image == "" || ingredients == nil || ingredients == []

    @label = label
    @url = url
    @uri = uri
    @image = image
    @ingredients = ingredients
  end

  def ingredients_text
    ingredients_list = []
    @ingredients.each do |ingred|
      ingredients_list << ingred["text"]
    end
    return ingredients_list
  end

  def uri_id
    return self.uri[/(?<=_)[a-zA-Z0-9]+/]
  end
end
