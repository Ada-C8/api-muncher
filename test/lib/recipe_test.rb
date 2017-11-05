require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'

describe Recipe do
  it "can be created" do
    recipe = Recipe.new "label", "uri", "image"

    recipe.must_respond_to :label
    recipe.wont_be_nil
    recipe.label.must_equal "label"

    recipe.must_respond_to :uri
    recipe.uri.must_equal "uri"

    recipe.must_respond_to :image
    recipe.image.must_equal "image"
  end

  it "requires 3 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError
  end

end
