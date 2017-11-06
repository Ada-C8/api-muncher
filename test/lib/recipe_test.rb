require 'test_helper'

describe "Recipe" do
  it "a new instance of recipe can be made" do
    recipe = Recipe.new "uri", "label", "image", "source", "url", "yields", "ingredients", "dietlabels"
    recipe.must_respond_to :label
    recipe.must_respond_to :uri
    recipe.must_respond_to :image
    recipe.must_respond_to :source
    recipe.must_respond_to :url
    recipe.must_respond_to :yield
    recipe.must_respond_to :ingredients
    recipe.must_respond_to :dietlabels
  end

  it "can't be created if missing params" do
    proc {Recipe.new}.must_raise ArgumentError

    proc{Recipe.new "uri"}.must_raise ArgumentError
  end
end
