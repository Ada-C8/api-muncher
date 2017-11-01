require 'test_helper'

describe Recipe do

  it "can be created" do
    my_recipe = Recipe.new("foodie surprise", "surprise.recipe.com", "uri.surprise.recipe.com", "surprise.recipe.com/photo.png", "4", ["surprise1", "mystery1"], ["not_diet_food", "comfort_food"])

    [:name, :url, :uri, :image_url, :yield, :ingredients, :diet_labels].each do |method|
      my_recipe.must_respond_to method
    end

    my_recipe.wont_be_nil
    my_recipe.name.must_equal "foodie surprise"
    my_recipe.uri.must_equal "uri.surprise.recipe.com"
  end

  it "requires at least seven parameters (name, url, uri, image_url, yield, ingredients, and diet labels) to be created" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "my new food" "has_website_but_nothing_else.com"
    }.must_raise ArgumentError

  end
  
end
