require 'test_helper'

describe Recipe do
  it "Can be initialized with required parameters" do
    uri = "test_uri"
    recipe = Recipe.new(uri)
    recipe.uri.must_equal uri
  end

  it "Cannot be initialized with invalid parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new("")
    }.must_raise ArgumentError
  end

  it "Tracks all optional arguments" do
    options = {
      label: "test_label",
      image: "test_image",
      source: "test_source",
      url: "test_url",
      yield: "test_yield",
      calories: "test_calories",
      totalWeight: "test_totalWeight",
      ingredients: "test_ingredients",
      totalNutrients: "test totalNutrients",
      totalDaily: "test_totalDaily",
      dietLabels: "test_dietLabels",
      healthLabels: "test_healthLabels"
    }
    recipe = Recipe.new("uri", options)

    recipe.label.must_equal options[:label]
    recipe.image.must_equal options[:image]
    recipe.source.must_equal options[:source]
    recipe.url.must_equal options[:url]
    recipe.yield.must_equal options[:yield]
    recipe.calories.must_equal options[:calories]
    recipe.totalWeight.must_equal options[:totalWeight]
    recipe.ingredients.must_equal options[:ingredients]
    recipe.totalNutrients.must_equal options[:totalNutrients]
    recipe.totalDaily.must_equal options[:totalDaily]
    recipe.dietLabels.must_equal options[:dietLabels]
    recipe.healthLabels.must_equal options[:healthLabels]
  end
end
