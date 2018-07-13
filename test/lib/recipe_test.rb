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
      recipe.uri_hash.must_equal "URI"
      recipe.photo_uri.must_equal "Photo URI"
      recipe.ingredients.must_equal "Ingredients"
    end

    it "Initializes optional fields properly as well" do
      recipe = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients", external_url: "Another URL", source: "Recipe Book")
      recipe.external_url.must_equal "Another URL"
      recipe.source.must_equal "Recipe Book"
    end
  end

  describe "== (equality)" do
    it "returns true if all attributes are the same" do
      recipe1 = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients")

      recipe2 = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients")

      (recipe1==recipe2).must_equal true
    end

    it "returns false if one attribute differs" do
      recipe1 = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients")

      recipe2 = Recipe.new("Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients", source: "Recipe Book")

      (recipe1==recipe2).must_equal false

      recipe3 = Recipe.new("Something other than Title", (EdamamApiWrapper::RECIPE_URL + "URI"), "Photo URI", "Ingredients")

      (recipe1==recipe3).must_equal false
    end
  end #== (equality)
end
