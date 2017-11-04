class Recipe
  attr_reader :url, :label, :image, :uri, :source, :diet_labels, :health_labels
# , image, ingredients, source, diet_labels
  def initialize(uri, url, label, options = {} )
    raise ArgumentError if url == nil || url == "" || label == nil || label == "" || uri == nil || uri == ""

    @uri = uri
    @url = url
    @label = label
    @image = options[:image]
    @ingredients = options[:ingredients]
    @source = options[:source]
    @diet_labels = options[:dietLabels]
    @health_labels = options[:healthLabels]
  end

  def ingredients
    ingredient_list = []
    @ingredients.each do |ingredient|
      ingredient_list << ingredient["text"]
    end
    return ingredient_list
  end

  def id
    return self.uri[/(?<=_)[a-zA-Z0-9]+/]
  end
end
