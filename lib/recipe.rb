class Recipe

  attr_reader :uri, :label, :image, :source, :url, :dietLabels, :healthLabels, :ingredientLines

  def initialize(api_response)
    #raise ArgumentError if label == nil || label == "" || uri == nil || uri == ""

    @uri = URI.escape(response['uri'])
    @label = response['label']
    @image = response['image']
    @source = response['source']
    @url = response['url']
    @dietLabels = response['dietLabels']
    @healthLabels = response['healthLabels']
    @ingredientLines = response['ingredientLines']
  end

end
