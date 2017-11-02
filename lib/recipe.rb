class Recipe
  attr_reader :url, :label, :image, :uri, :source, :diet_labels
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
  end

  def ingredients
    ingredient_list = []
    @ingredients.each do |ingredient|
      ingredient_list << ingredient["text"]
    end
    return ingredient_list
  end

  def id
    #http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
    return self.uri[/(?<=_)[a-zA-Z0-9]+/]

  end
end
