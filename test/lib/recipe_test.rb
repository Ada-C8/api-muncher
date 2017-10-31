require 'test_helper'

describe Recipe do

  it "can be created" do
    my_recipe = Recipe.new "label", "url", "ingredients", "image", "source"

    my_recipe.wont_be_nil
    my_recipe.label.must_equal "label"
    my_recipe.url.must_equal "url"
    my_recipe.ingredients.must_equal "ingredients"
    my_recipe.image.must_equal "image"
    my_recipe.source.must_equal "source"
  end
  it "requires 5 parameters" do

  end

end
