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

    it "Raises an ApiError when token is bad" do
      VCR.use_cassette("recipes") do
        proc {
          ApiWrapper.list_recipes("bogus_token").must_raise ApiWrapper::ApiError
        }
      end
    end
  end
end
