require 'test_helper'

describe RecipeApiWrapper do
  it "can get a list of recipes" do
    VCR.use_cassette("recipes") do
      result = RecipeApiWrapper.search("cheese")
      result.must_be_kind_of Array
    end
  end
end
