require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'

describe RecipeShow do
  it "can be created" do
    recipe = RecipeShow.new "label", "url", "ingredients", "healthlabels", "image", "source"

    recipe.must_respond_to :label
    recipe.wont_be_nil
    recipe.label.must_equal "label"

    recipe.must_respond_to :url
    recipe.url.must_equal "url"

    recipe.must_respond_to :ingredients
    recipe.ingredients.must_equal "ingredients"

    recipe.must_respond_to :healthlabels
    recipe.healthlabels.must_equal "healthlabels"

    recipe.must_respond_to :image
    recipe.image.must_equal "image"

    recipe.must_respond_to :source
    recipe.source.must_equal "source"
  end

  it "requires 6 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError
  end

end
