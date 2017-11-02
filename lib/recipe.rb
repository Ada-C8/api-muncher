class Recipe
  attr_reader :uri, :title, :image, :diet_label, :url, :ingredient_lines

  def initialize(uri, title, options = {} )
    raise ArgumentError if title == nil || title == "" || uri == nil || uri == ""


    @title = title
    @uri = uri

    @image = options["image"]
    @diet_label = options["dietLabels"]
    @url = options["url"]
    @ingredient_lines = options["ingredientLines"]
  end
end
