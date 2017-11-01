class Recipe

  attr_reader :uri, :label, :image, :ingredients, :dietaryinfo

  def initialize(uri, label, options = {})
    raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = URI.escape(uri)
    @label = label
    @image = options[:image]
    @ingredient = options[:ingredients]
    @dietaryinfo = options[:dietaryinfo]

  end

end
