require 'test_helper'

describe Recipe do

  it "Can be instantiated with required fields" do
    Recipe.new("name", "image", "source", "url", "ingredients")
  end

  it "Requires a name, image, source, url, and ingredients" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name")
    }.must_raise ArgumentError

    # Empty strings are not permitted either
    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end

  it "Tracks name, image, source, url, and ingredients" do
    name = "test_name"
    image = "test_image"
    source = "test_source"
    url = "test_url"
    ingredients = "test_ingredients"

    recipe = Recipe.new(name, image, source, url, ingredients)

    recipe.name.must_equal name
    recipe.image.must_equal image
    recipe.source.must_equal source
    recipe.url.must_equal url
    recipe.ingredients.must_equal ingredients
  end

  it "Tracks optional args" do
    options = {
      servings: "test_servings",
      diet: "test_diet",
      health: "test_health",
      calories: "test_calories"
    }
    recipe = Recipe.new("name", "image", "source", "url", "ingredients", options)

    recipe.servings.must_equal options[:servings]
    recipe.diet.must_equal options[:diet]
    recipe.health.must_equal options[:health]
    recipe.calories.must_equal options[:calories]
  end
end
