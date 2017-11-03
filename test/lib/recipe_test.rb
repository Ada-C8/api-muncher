require 'test_helper'

describe "Recipe" do
  it "can be created" do

    my_recipe = Recipe.new "label", "uri", "url", "image"

    my_recipe.must_respond_to :label
    my_recipe.wont_be_nil
    my_recipe.label.must_equal "label"
    my_recipe.id.must_equal "id"

  end
end
