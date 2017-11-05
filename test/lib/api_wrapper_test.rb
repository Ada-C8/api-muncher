require 'test_helper'

describe ApiWrapper do
  describe "list_recipes" do
    it "get list of recipes" do
      VCR.use_cassette("recipes") do
        result = ApiWrapper.list_recipes("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "search for something that does not exist return []" do
      

    end

    it "Raises an ApiError when token is bad" do
      begin # something which might raise an exception
        origin_token = ApiWrapper::TOKEN
        ApiWrapper::TOKEN = "bogus_token"
        VCR.use_cassette("recipes") do
          proc {
            ApiWrapper.list_recipes("chicken")
          }.must_raise ApiWrapper::ApiError
        end
      ensure
        # ensure that this code always runs, no matter what
        # it does not change the final value of the block
        ApiWrapper::TOKEN = origin_token
      end
    end
  end
end
