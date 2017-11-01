class Recipe
  attr_reader :label, :url, :uri, :image, :source, :health_labels

  def initialize(label, url, uri, image, source, ingredients, options = {} )
    raise ArgumentError if label == nil || label == "" || url == nil || url == "" || image == nil || image == "" || source == "" || source == nil || ingredients == nil || ingredients == []

    @label = label
    @url = url
    @uri = uri
    @image = image
    @source = source
    @ingredients = ingredients

    @health_labels = options[:health_labels]
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
