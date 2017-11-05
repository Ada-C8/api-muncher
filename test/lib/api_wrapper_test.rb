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
      VCR.use_cassette("recipes") do
        result = ApiWrapper.list_recipes("")
        result.must_equal []
      end
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

        # in this case we want ensure because we may need the correct TOKEN for future tests
        ApiWrapper::TOKEN = origin_token
      end
    end
  end

  describe "find_recipe" do
    it "Raises error with bogus uri" do

      bogus_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61db451818c3293df2"
      VCR.use_cassette("uri_testing") do
        proc {
          ApiWrapper.find_recipe(bogus_uri)
        }.must_raise ApiWrapper::ApiError
      end
    end
  end
end
