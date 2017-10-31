require 'test_helper'

describe Recipe do

  it "can be created" do
    recipe = Recipe.new("name","uri")
    recipe.must_be_instance_of Recipe
    recipe.must_respond_to :label
    recipe.label.must_equal "name"
    recipe.uri.must_equal "uri"
  end

  it "must have two parameters" do
    proc{Recipe.new}.must_raise ArgumentError
    proc{Recipe.new "name"}.must_raise ArgumentError
  end

end
