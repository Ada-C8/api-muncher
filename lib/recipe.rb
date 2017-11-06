class Recipe
  attr_reader :name, :image, :uri, :url, :source,  :ingredients, :nutrition, :diet_labels, :health_labels

  def initialize(name, image, uri, options = {})
    raise ArgumentError if name == nil || image == nil || uri == nil || name == "" || image == "" || uri == ""

    @name = name
    @image = image
    @uri = encode_uri(uri)
    # optional variables

    @source = options[:source]
    @url = options[:url]
    @ingredients = options[:ingredients]
    @nutrition = options[:nutrition]
    @diet_labels = options[:diet_labels]
    @health_labels = options[:health_labels]
  end

  private

  def encode_uri(uri)
    uri.gsub(/#/, '%23')
  end
end
