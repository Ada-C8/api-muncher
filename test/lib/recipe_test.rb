require 'test_helper'

describe Recipe do
  it "can be instantiated with all required data" do
    recipe_data = {
      uri: "uri",
      name: "name",
      source: "source",
      link: "link",
      image: "image",
      ingredients: "ingredients",
      dietary: "dietary"
    }
    recipe = Recipe.new(recipe_data[:uri], recipe_data[:name], recipe_data[:source], recipe_data[:link], recipe_data[:image], recipe_data[:ingredients], recipe_data[:dietary])

    recipe.must_be_kind_of Recipe
  end

  it "requires all required data to be instantiated" do
    proc { Recipe.new() }.must_raise ArgumentError
    proc { Recipe.new("") }.must_raise ArgumentError
  end

  it "tracks all the arguments" do
    recipe_data = {
      uri: "test uri",
      name: "test name",
      source: "test source",
      link: "test link",
      image: "test image",
      ingredients: "test ingredients",
      dietary: "test dietary"
    }

    recipe = Recipe.new(recipe_data[:uri], recipe_data[:name], recipe_data[:source], recipe_data[:link], recipe_data[:image], recipe_data[:ingredients], recipe_data[:dietary])

    recipe.uri.must_equal recipe_data[:uri]
    recipe.name.must_equal recipe_data[:name]
    recipe.source.must_equal recipe_data[:source]
    recipe.link.must_equal recipe_data[:link]
    recipe.image.must_equal recipe_data[:image]
    recipe.ingredients.must_equal recipe_data[:ingredients]
    recipe.dietary.must_equal recipe_data[:dietary]
  end
end
