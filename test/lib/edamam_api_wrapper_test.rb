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

    #never a bad status??
    it "should raise an ApiError when the app_id and app_key are invalid" do
      VCR.use_cassette("apple") do
        proc {
          EdamamApiWrapper.search("apple", "bad_app_id", "bad_app_key")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

    describe "#self.find_recipe" do
      it "should return a Recipe object" do

      end

      it "should raise an ApiError if recipe id is invalid" do

      end

      it "should raise an ArgumentError if id is not given" do

      end
    end

  end







end
