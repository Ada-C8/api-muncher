require 'test_helper'

describe "Recipe" do


  it "Can create an instance of a recipe." do
    recipe = Recipe.new("uri", "title", "image", "ingredients", "dietary", "link")

    recipe.class.must_equal Recipe
  end

  it "Can recognize all created accessors." do
    recipe = Recipe.new("uri", "title", "image", "ingredients", "dietary", "link",)

    recipe.uri.must_equal "uri"
    recipe.title.must_equal "title"
    recipe.image.must_equal "image"
    recipe.ingredients.must_equal "ingredients"
    recipe.dietary.must_equal "dietary"
    recipe.link.must_equal "link"
  end
end
