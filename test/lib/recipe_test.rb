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
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "label"
    }.must_raise ArgumentError

    proc {
      Recipe.new "label", "url", "ingredients", "source"
    }.must_raise ArgumentError
  end
  it "takes diet_labels and health_labels as optional params" do
    my_recipe = Recipe.new "label", "url", "ingredients", "image", "source", {diet_labels: ["vegetarian", "vegan"], health_labels: ["nut-free"]}

    my_recipe.wont_be_nil
    my_recipe.diet_labels.must_be_instance_of Array
    my_recipe.health_labels.must_be_instance_of Array
  end

end
