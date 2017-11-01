class Recipe
  attr_reader :name, :image, :source, :url, :servings, :diet, :health, :ingredients, :calories

  def initialize(name, image, source, url, servings, diet, health, ingredients, calories )
    @name = name
    @image = image
    @source = source
    @url = url
    @servings = servings
    @diet = diet
    @health = health
    @ingredients = ingredients
    @calories = calories
  end
end
