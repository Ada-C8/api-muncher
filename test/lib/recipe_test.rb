require 'test_helper'



describe Recipe do

  it "Can be instantiated with a label and a uri" do
    Recipe.new("label", "uri")
  end #can be instantiated

  it "Requires a label and a uri" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("label")
    }.must_raise ArgumentError

    proc {
      Recipe.new("uri")
    }.must_raise ArgumentError

    # Empty strings are not permitted either
    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end #requirements

  it "Tracks label and uri" do
    label = "test_label"
    uri = "test_uri"
    result = Recipe.new(uri, label)
    result.label.must_equal label
    result.uri.must_equal uri
  end #tracks label and uri

  it "Tracks optional args" do

    label = "test_label"
    uri = "test_uri"

    options = {

      image: "test_image",
      source: "test_source",
      shareAs: "test_members",
      ingredientLines: "ingredient_lines",
      calories: 12,
      amount: 0,
      dietLabels: "diet_labels",
      healthLabels: "health_labels"
    }

    result = Recipe.new(uri, label, options)

    result.image.must_equal options[:image]
    result.source.must_equal options[:source]
    result.shareAs.must_equal options[:shareAs]
    result.ingredientLines.must_equal options[:ingredientLines]
    result.calories.must_equal options[:calories]
    result.amount.must_equal options[:amount]
    result.dietLabels.must_equal options[:dietLabels]
    result.healthLabels.must_equal options[:healthLabels]
  end #tracks optionals
end #all tests
