require 'test_helper'

describe "Recipe" do

  it "requires 7 arguments to initialize" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new("title")
    }.must_raise ArgumentError

    proc {
      Recipe.new("title", "id", "dietlabels")
    }.must_raise ArgumentError
  end

  it "can create a Recipe instance" do
    recipe = Recipe.new("title", "id", "image", "dietlabels", "ingredients", "provider", "link")

    recipe.class.must_equal Recipe
  end

  it "can create a recipe given all params" do

    recipe = Recipe.new("title", "id", "image", "dietlabels", "ingredients", "provider", "link")

    recipe.class.must_equal Recipe
  end

  it "recognizes accessor methods" do
    recipe = Recipe.new("title", "id", "image", "dietlabels", "ingredients", "provider", "link")

    recipe.title.must_equal "title"
    recipe.image.must_equal "image"
    recipe.dietlabels.must_equal "dietlabels"
    recipe.ingredients.must_equal "ingredients"
    recipe.provider.must_equal "provider"
    recipe.link.must_equal "link"
  end


end
