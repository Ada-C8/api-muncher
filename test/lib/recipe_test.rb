require 'test_helper'


describe Recipe do

  it "can be created" do
    recipe = Recipe.new "uri", "label", "image", "url", "ingredientLines"
    recipe.must_respond_to :name
    recipe.must_respond_to :uri
    recipe.must_respond_to :image
    recipe.must_respond_to :link
    recipe.must_respond_to :ingredients
    recipe.wont_be_nil
    recipe.name.must_equal "label"
    recipe.link.must_equal "url"
  end

  it "won't be created without all required parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError
    proc {
      Recipe.new "label", "image", "url", "ingredientLines"
    }.must_raise ArgumentError
    proc {
      Recipe.new "uri", "label", "image"
    }.must_raise ArgumentError
  end

end
