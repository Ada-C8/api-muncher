require 'test_helper'

describe EdamamApiWrapper do
  describe "search_recipes" do
    it "Can get a list of recipes" do
      VCR.use_cassette("recipes") do
        query = "eggs"
        response = EdamamApiWrapper.search_recipes(query)
        response.must_be_kind_of Hash
        response.length.must_be :>, 0
      end
    end
  end

  describe "show_recipe" do
    it "Will show Recipe if given uri" do
      VCR.use_cassette("recipes") do
        uri = "recipe_7d222a612deb4bc263532f75d4071da1"
        result = EdamamApiWrapper.show_recipe(uri)
        result.must_be_kind_of Recipe
      end
    end

    it "Raises an error if the uri does not exist" do
      VCR.use_cassette("recipes") do
        proc {
          uri = "whatacrazyurihehehehehehe"
          EdamamApiWrapper.show_recipe(uri)
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

    it "Raises an error if not given a uri" do
      VCR.use_cassette("recipes") do
        proc {
          EdamamApiWrapper.show_recipe("")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

  end
end
