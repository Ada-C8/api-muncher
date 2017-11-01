
require 'test_helper'

describe EdamamApiWrapper do
  describe "search" do
    it "Can get an array of recipe objects" do
      VCR.use_cassette("recipes") do
        result = EdamamApiWrapper.search("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "raises an error when given an empty string for the search term" do
      #TODO
    end

    it "Raises an ApiError when the tokens are bad" do
      VCR.use_cassette("invalid_tokens") do
        proc {
          EdamamApiWrapper.search("chicken", "bogus_token1", "bogus_token2")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end

  describe "find_recipe" do
    it "returns a recipe" do
      VCR.use_cassette("find_recipe") do
        valid_uri = "637913ec61d9da69eb451818c3293df2"
        result = EdamamApiWrapper.find_recipe(valid_uri)
        result.must_be_kind_of Recipe
      end
    end



    it "raises an error when given an invalid uri id" do
      #TODO
    end

    it "raises an error when given an invalid BASE_URI" do
      #TODO
    end
  end


end
