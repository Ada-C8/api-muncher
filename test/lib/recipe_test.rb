require 'test_helper'

describe Recipe do
  it "can be instantiated with label, uri, and options" do
    Recipe.new("label", "uri")
  end

  it "requires a label and uri" do
    proc{Recipe.new()}.must_raise ArgumentError
    proc{Recipe.new("label")}.must_raise ArgumentError
    proc{Recipe.new("", "")}.must_raise ArgumentError
  end

  it "tracks label and uri" do
    label = "test_label"
    uri = "test_uri"
    rec = Recipe.new(label, uri)
    rec.label.must_equal label
    rec.uri.must_equal uri
  end

  it "tracks optional args" do
    options = {
      health: "test_health",
      image: "test_image",
      ingredients: "test_ingredients",
      source: "test_source"
    }

    rec = Recipe.new("label", "uri", options)
    rec.health.must_equal options[:health]
    rec.image.must_equal options[:image]
    rec.ingredients.must_equal options[:ingredients]
    rec.source.must_equal options[:source]

  end

end
