class Recipe
  attr_reader :label, :url, :uri, :image, :source, :health_labels

  def initialize(label, uri, options = {} )
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @label = label
    @uri = uri

    @url = options[:url]
    @image = options[:image]
    @source = options[:source]
    @ingredients = options[:ingredients]
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
