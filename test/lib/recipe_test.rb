require 'test_helper'

describe Recipe do
  it "must initialize name, uri, and image properly" do
    recipe = Recipe.new(name: "Name", uri: "ID", image: "www.fake_img.com")
    recipe.name.must_equal "Name"
    recipe.uri.must_equal "ID"
    recipe.image.must_equal "www.fake_img.com"
  end

  it "Cannot be initialized with less than 3 parameters" do
    proc {
      Recipe.new
    }.must_raise ArgumentError

    proc {
      Recipe.new "Name"
    }.must_raise ArgumentError
  end

  it "track optional arguments" do
      recipe = Recipe.new(name: "Name",
                          uri: "ID",
                          image: "www.fake_img.com",
                          diet_labels: "diet_labels",
                          ingredient_lines: "ingredient_lines",
                          health_labels: "health_labels",
                          total_nutrients: "total_nutrients",
                          calories: "calories",
                          servings: "servings",
                          ingredients: "ingredients"
                        )
      recipe.diet_labels.must_equal "diet_labels"
      recipe.ingredient_lines.must_equal "ingredient_lines"
      recipe.health_labels.must_equal "health_labels"
      recipe.total_nutrients.must_equal "total_nutrients"
      recipe.calories.must_equal "calories"
      recipe.servings.must_equal "servings"
      recipe.ingredients.must_equal "ingredients"
  end
end
