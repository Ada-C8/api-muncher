require 'test_helper'

describe Recipe do

  it "Can be instantiated with id, name, image, url, ingredients, servings, and total nutrients" do
    id = "id"
    name = "name"
    image = "image"
    url = "url"
    ingredients = "ingredients"
    servings = "servings"
    recipe = Recipe.new(id, name, image, url, ingredients, servings)
    recipe.must_be_instance_of Recipe
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

    recipe = Recipe.new(id, name, image, url, ingredients, servings)
    recipe.name.must_equal name
    recipe.id.must_equal id
    recipe.image.must_equal image
    recipe.url.must_equal url
    recipe.ingredients.must_equal ingredients
    recipe.servings.must_equal servings

  end

  it "Tracks the optional attributes that are passed" do
    id = "id"
    name = "name"
    image = "image"
    url = "url"
    ingredients = "ingredients"
    servings = "servings"

    options = {
      source: "source",
      health_labels: "health labels",
      calories: "calories",
      fat: "fat",
      carbs: "carbs",
      protein: "protein"
    }

    recipe = Recipe.new(id, name, image, url, ingredients, servings, options)
    recipe.source.must_equal options[:source]
    recipe.health_labels.must_equal "health labels"
    recipe.calories.must_equal options[:calories]
    recipe.fat.must_equal "fat"
    recipe.carbs.must_equal options[:carbs]
    recipe.protein.must_equal "protein"

  end
end
