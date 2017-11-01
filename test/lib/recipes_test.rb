require 'test_helper'

describe Recipe do

  it "Can be instantiated with id, name, image, url, ingredients, servings, and total nutrients" do
    Recipe.new(id: "id", name: "name", image: "image", url: "url", ingredients: "ingredients", servings: "servings", total_nutrients: "total_nutrients")
  end

  it "Requires a name" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    # empty strings are not permitted either
    proc {
      Recipe.new("", "")
    }.must_raise ArgumentError
  end

  it "Tracks the required attributes that are passed" do
    id = "id"
    name = "name"
    image = "image"
    url = "url"
    ingredients = "ingredients"
    servings = "servings"
    total_nutrients = "total_nutrients"


    recipe = Recipe.new(id: id, name: name, image: image, url: url, ingredients: ingredients, servings: servings, total_nutrients: total_nutrients)
    recipe.name.must_equal name
    recipe.id.must_equal id
    recipe.image.must_equal image
    recipe.url.must_equal url
    recipe.ingredients.must_equal ingredients
    recipe.servings.must_equal servings
    recipe.total_nutrients.must_equal total_nutrients

  end

end
