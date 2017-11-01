require 'test_helper'
require "httparty"

describe EdamamApiWrapper do
  describe "get_recipies" do
    it "can return a list of recipies" do
      VCR.use_cassette("recipes") do
        result = EdamamApiWrapper.get_recipies("bread")
        result.must_be_kind_of Array
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end # .each
        result.length.must_be :>, 0
      end # VCR
    end # it can return a list of recipies

    it "will raise an error if the key is bad" do
      VCR.use_cassette("recipies") do
        proc {EdamamApiWrapper.get_recipies("bread", "badkey")}.must_raise EdamamApiWrapper::ApiError
      end # VCR
    end # bad token

    it "will raise an error if given a bugus search term that it has no results for" do
      # TODO
      # Maybe test response["count"] > 0?
      VCR.use_cassette("recipies") do
        proc {EdamamApiWrapper.get_recipies("xcd")}.must_raise EdamamApiWrapper::NoResultsError
      end # VCR
    end # bogus search term
  end # get_recipies

  describe "show_recipe" do
    it "will return an instance of recipe" do
      VCR.use_cassette("recipies") do
        # pass in an unencoded uri (got this one from pulling it out of the API response to get_recipies)
        result = EdamamApiWrapper.show_recipe("http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2")
        result.must_be_kind_of Recipe
      end # VCR
    end # return an instance

    it "will raise an error if given a bogus uri" do
      # TODO: figure out how to test this! There is something going wrong before I get to the error??
      VCR.use_cassette("recipies") do
        proc {EdamamApiWrapper.show_recipe("bogus_uri")}.must_raise EdamamApiWrapper::ApiError
          # proc {EdamamApiWrapper.show_recipe("bogus_uri")}.must_raise JSON::ParserError
      end # VCR
    end
  end # show_recipe
end # EdamamApiWrapper
