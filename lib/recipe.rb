class Recipe

  attr_reader :title, :ingredients, :calories, :health_labels, :diet_labels, :image, :link, :uri

  def initialize(response)
    @uri = URI.escape(response['uri'])
    @title = response['label']
    @ingredients = response['ingredientLines']
    @calories = response['calories']
    @health_labels = response['healthLabels']
    @diet_labels = response['dietLabels']
    @image = response['image']
    @link = response['url']
  end

end
