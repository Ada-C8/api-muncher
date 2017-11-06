require 'test_helper'

describe Recipe do
  it "can be created" do
    new_recipe = Recipe.new(name: "Chicken Fritters", id: "id_value", url: "recipe.com", ingredients: "chicken")
    new_recipe.must_be_instance_of Recipe
    new_recipe.must_respond_to :name
    new_recipe.wont_be_nil
    new_recipe.name.must_equal "Chicken Fritters"
    new_recipe.url.must_equal "recipe.com"
    new_recipe.ingredients.must_equal "chicken"
  end

  it "returns an error if no parameters are passed" do
    proc { Recipe.new }.must_raise ArgumentError
  end

  it "returns an error if not all required parameters are passed" do
    proc { Recipe.new(name: "Chicken")}.must_raise ArgumentError
  end
end
