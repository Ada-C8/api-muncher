require 'test_helper'
require 'pry'
describe RecipeApiWrapper do
  it "can search for a list of recipes" do
    VCR.use_cassette("recipes") do
      result = RecipeApiWrapper.search("cheese", 10)
      result.must_be_kind_of Array
      result.length.must_be :>, 0
      result.each do |recipe|
        recipe.must_be_kind_of Recipe
      end
    end
  end

  it "does returns nil when the API is not working" do
    VCR.use_cassette("no_recipes") do
      result = RecipeApiWrapper.search("kljkjlk", 10)
      result.must_be_kind_of Array
      result.must_be_empty
    end
  end

  it "can find a specific recipe" do
    uri = ""
    VCR.use_cassette("recipes") do
      result = RecipeApiWrapper.search("cheese", 10)
      uri = result[0].id
    end

    VCR.use_cassette("recipe") do
      recipe = RecipeApiWrapper.find(uri)
      recipe.must_be_kind_of Recipe
    end
  end

  it "will return nil if recipe uri is invalid or not found" do
    VCR.use_cassette("no_recipe") do
      recipe = RecipeApiWrapper.find("kjljkljljl")
      recipe.must_be_nil
    end
  end

end
