class Recipe
  attr_reader :url, :label, :image, :uri

  def initialize(uri, url, label, image, ingredients, options = {} )
    raise ArgumentError if url == nil || url == "" || label == nil || label == "" || image == nil || image == ""

    @url = url
    @label = label
    @image = image
    @ingredients = ingredients
    @uri = uri
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
