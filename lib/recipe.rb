class Recipe

  attr_reader :uri, :label, :image, :ingredients, :dietaryInfo, :url, :calories, :totalNutrients

  def initialize(uri, label, options = {})
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = URI.escape(uri)
    @label = label
    @image = options[:image]
    @ingredients = options[:ingredients]
    @url = options[:url]
    @calories = options[:calories]
    @totalNutrients = options[:totalNutrients]


  end

end
