class Recipe
  attr_reader :uri, :label, :source, :image, :short_uri, :shareAs, :ingredientLines, :amount, :calories, :dietLabels, :healthLabels

  def initialize(uri, label, options = {} )
    raise ArgumentError if uri == "" || label == ""

    @label = label
    @uri = uri

    @short_uri = @uri.split('#')[1]

    @image = options[:image]
    @source = options[:source]
    # @url = options[:url]
    @shareAs = options[:shareAs]
    @ingredientLines = options[:ingredientLines]
    @calories = options[:calories].to_i
    @amount = options[:yield].to_i
    @dietLabels = options[:dietLabels]
    @healthLabels = options[:healthLabels]
  end

end
