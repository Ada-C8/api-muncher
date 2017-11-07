require 'test_helper'

describe "Recipe" do

  it "can be instantiated" do
    Recipe.new("uri", "label", "image", "url")
  end

  it "requires a uri, label, image and url" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("uri")
    }.must_raise ArgumentError

    proc {
      Recipe.new("", "", "", "")
    }.must_raise ArgumentError
  end

  it "tracks params" do
    uri  = "test_uri"
    label = "test_label"
    image = "test_image"
    url = "test_url"
    my_recipe = Recipe.new(uri, label, image, url)
    my_recipe.uri.must_equal uri
    my_recipe.label.must_equal label

  end
end
