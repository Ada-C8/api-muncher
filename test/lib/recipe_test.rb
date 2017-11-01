require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'

describe Recipe do
  it "requires one parameter" do
    #error if no keyword is passed to it
    proc {
      Recipe.new
    }.must_raise ArgumentError
  end

  it "can be created" do
      a_recipe= Recipe.new "lemon"
      a_recipe.must_respond_to :uri
      a_recipe.must_respond_to :label
      a_recipe.must_respond_to :image
      a_recipe.must_respond_to :source
      a_recipe.must_respond_to :url
      a_recipe.must_respond_to :dietLabels
      a_recipe.must_respond_to :healthLabels
      a_recipe.must_respond_to :ingredientLines
      a_recipe.wont_be_nil
      a_recipe.label.must_equal "label"
      a_recipe.uri.must_equal "uri"
  end

end
