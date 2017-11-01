require 'test_helper'
require 'pry'
describe RecipeApiWrapper do
  it "can get a list of recipes" do
    VCR.use_cassette("recipes") do
      result = RecipeApiWrapper.search("cheese", 10)
      result.must_be_kind_of Array
      result.length.must_be :>, 0
      result.each do |recipe|
        recipe.must_be_kind_of Recipe
      end
    end
  end


end
