require 'test_helper'

describe Recipe do
  it "Can create a recipe" do
    new_recipe = Recipe.new "test", "test", "test", "test", "test", "test", "test"

    new_recipe.must_respond_to :label
    new_recipe.must_respond_to :dietLabels
    new_recipe.must_respond_to :image
    new_recipe.must_respond_to :url
    new_recipe.must_respond_to :source
    new_recipe.must_respond_to :ingredients
    new_recipe.must_respond_to :uri
  end

  it "Requires 7 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "test", "test", "test", "test", "test", "test"
    }.must_raise ArgumentError

  end
end
