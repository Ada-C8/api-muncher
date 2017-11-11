require 'test_helper'

describe "EdamamApiWrapper" do

  describe "#self.search" do
    it "should return a list of recipes" do
    VCR.use_cassette("apple") do
        result = EdamamApiWrapper.search("apple")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "should raise an ApiError when the app_id and app_key are invalid" do
      VCR.use_cassette("apple") do
        proc {
          EdamamApiWrapper.search("apple", "bad_app_id", "bad_app_key")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

    # What if the search term yields 0 results? Something like "fkljadlfjaljfaljfalkdjf" would probably do

    it "should return an empty array if search term yields 0 results" do
      VCR.use_cassette("no_search_results") do
        result = EdamamApiWrapper.search("asdfasfasdfasdf")

        result.must_equal []
      end
    end
  end

  describe "#self.find_recipe" do
    it "should return a Recipe object" do
      VCR.use_cassette("specific recipe") do
        result = EdamamApiWrapper.find_recipe("b1957a6a4025b25f6da6aef1fad452d4")
        result.must_be_instance_of Recipe
      end
    end

    it "should raise ApiError if recipe is not found" do
      VCR.use_cassette("bad recipe") do
        proc { EdamamApiWrapper.find_recipe("nope nope nope") }.must_raise EdamamApiWrapper::ApiError
      end
    end

    it "should raise ApiError if id is not given" do
      VCR.use_cassette("no recipe") do
      proc { EdamamApiWrapper.find_recipe("") }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end
end
