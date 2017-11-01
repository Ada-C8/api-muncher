require "test_helper"

describe "recipe" do
  it "can be instantiated" do
    Recipe.new("label","uri")
  end

  it "requires a label and a uri" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("label")
    }.must_raise ArgumentError

    # empty strings are not permitted either
    proc {
      Recipe.new("","")
    }.must_raise ArgumentError
  end

  it "tracks label and uri" do
    label = "test_label"
    uri = "test_uri"
    recipe = Recipe.new(label,uri)
    recipe.label.must_equal label
    recipe.uri.must_equal uri
  end

  it "tracks optional arguments" do
    options = {
      image: "test_image",
      url: "test_url",
      source: "test_source",
      yield: "test_yield",
      calories: "test_calories",
      ingredientLines: "test_ingredientLines",
      dietLabels: "test_dietLabels",
      healthLabels: "test_healthLabels",
      totalDaily: "test_totalDaily"
    }

    recipe = Recipe.new("test_label","test_uri",options)
    recipe.image.must_equal options[:image]
    recipe.url.must_equal options[:url]
    recipe.source.must_equal options[:source]
    recipe.yield.must_equal options[:yield]
    recipe.calories.must_equal options[:calories]
    recipe.ingredientLines.must_equal options[:ingredientLines]
    recipe.dietLabels.must_equal options[:dietLabels]
    recipe.healthLabels.must_equal options[:healthLabels]
    recipe.totalDaily.must_equal options[:totalDaily]
  end
end
