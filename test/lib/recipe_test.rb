require 'test_helper'

describe Recipe do
  it "can be created" do
    new_recipe = Recipe.new("Chicken Fritters", "recipe.com", "chicken")
    new_recipe.must_be_instance_of Recipe
    new_recipe.must_respond_to :name
    new_recipe.wont_be_nil
    new_recipe.name.must_equal "Chicken Fritters"
    new_recipe.url.must_equal "recipe.com"
    new_recipe.ingredients.must_equal "chicken"
  end

  it "returns an error if invalid parameters are passed" do
    proc { Recipe.new }.must_raise
  end
end
