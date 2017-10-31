class Recipe
  attr_reader :title, :ingredients, :calories, :health_labels, :diet_labels, :image, :link

  def initialize(response)
    @title = response['recipe']['label']
    @ingredients = response['recipe']['ingredientLines']
    @calories = response['recipe']['calories']
    @health_labels = response['recipe']['healthLabels']
    @diet_labels = response['recipe']['dietLabels']
    @image = response['recipe']['image']
    @link = response['recipe']['url']
  end

end
