require 'test_helper'

describe Recipe do

  # it blocks are placed here.
  it "Cannot be initialized with less than 7 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "Name"
    }.must_raise ArgumentError
  end

  it "Must initialize name & id properly" do
    recipe = Recipe.new("label", "recipe_url", "ingredients", "dietary", "image", "source", "uri")
    recipe.label.must_equal "label"
    recipe.recipe_url.must_equal "recipe_url"
    recipe.ingredients.must_equal "ingredients"
    recipe.dietary.must_equal "dietary"
    recipe.image.must_equal "image"
    recipe.source.must_equal "source"
    recipe.uri.must_equal "uri"
  end
end
