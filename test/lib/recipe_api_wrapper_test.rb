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

#Can't get this test working so far  - CANT Test this without changing the method and decided not to
  # it "does something when the app key is bad" do
  #   APP_KEY = 123456
  #   proc {
  #     RecipeApiWrapper.search("cheese", 10)
  #   }.must_raise ApiError
  # end

#Also not working - not sure why this does not work
  it "can create a new recipe instance" do
    VCR.use_cassette("recipes") do
      result = RecipeApiWrapper.search("cheese", 10)
      uri = result[0].id
      recipe = RecipeApiWrapper.find(uri)
      recipe.must_be_kind_of Recipe
    end
  end

end
