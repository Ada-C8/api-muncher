class Recipe
  attr_reader :uri, :label, :image, :source, :url, :ingredientLines, :dietLabels, :healthLabels

  def initialize(uri, label, image, source, url, options={})
    raise ArgumentError if label == nil || label == "" || url == nil || url == ""

    @uri = uri
    @label = label
    @image = image
    @source = source
    @url = url

    # optional variables
    @healthLabels = options[:healthLabels]
    @ingredientLines = options[:ingredientLines]
    @dietLabels = options[:dietLabels]
  end
end
