require 'test_helper'

describe Recipe do

  it "Can be instantiated with required fields" do
    Recipe.new("uri", "name")
  end

  it "Requires a uri and name" do
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

  it "Tracks uri, name, image, source, url, and ingredients" do
    uri = "testuri"
    name = "test_name"

    recipe = Recipe.new(uri, name)

    recipe.uri.must_equal uri
    recipe.name.must_equal name
  end

  it "Tracks additional args" do
    options = {
      image: "test_image",
      source: "test_source",
      url: "test_url",
      ingredients: "test_ingredients",
      servings: "test_servings",
      diet: "test_diet",
      health: "test_health",
      calories: "test_calories"
    }

    recipe = Recipe.new("uri", "name", options)

    recipe.image.must_equal options[:image]
    recipe.source.must_equal options[:source]
    recipe.url.must_equal options[:url]
    recipe.ingredients.must_equal options[:ingredients]
    recipe.servings.must_equal options[:servings]
    recipe.diet.must_equal options[:diet]
    recipe.health.must_equal options[:health]
    recipe.calories.must_equal options[:calories]
  end
end
