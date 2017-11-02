require 'test_helper'

describe Recipe do
  describe "initialization" do
    it "Cannot be initialized with less than 4 parameters" do
      proc { Recipe.new }.must_raise ArgumentError
      proc { Recipe.new "Title" }.must_raise ArgumentError
      proc { Recipe.new "Title", "URI" }.must_raise ArgumentError
      proc { Recipe.new "Title", "URI", "Photo URI" }.must_raise ArgumentError
    end

    it "Must initialize title, uri, photo_uri and ingredients properly" do
      recipe = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients")
      recipe.title.must_equal "Title"
      recipe.mini_uri.must_equal "URI"
      recipe.photo_uri.must_equal "Photo URI"
      recipe.ingredients.must_equal "Ingredients"
    end

    it "Initializes optional fields properly as well" do
      recipe = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients", external_url: "Another URL", source: "Recipe Book")
      recipe.external_url.must_equal "Another URL"
      recipe.source.must_equal "Recipe Book"
    end
  end
end
