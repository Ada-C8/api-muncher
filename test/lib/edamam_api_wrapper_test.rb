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
        # TODO: figure out why the uri is being encoded incorrectly
        # encoded_uri = URI.encode("http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2")
        result = EdamamApiWrapper.show_recipe("http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2")
        result.must_be_kind_of Recipe
      end # VCR
    end # return an instance

    # it "will raise an error if given a bogus uri" do
    #   VCR.use_cassette("recipies") do
    #     encoded_uri = URI.encode("bogus")
    #     proc {EdamamApiWrapper.show_recipe(encoded_uri)}.must_raise EdamamApiWrapper::ApiError
    #   end # VCR
    # end
  end # show_recipe
end # EdamamApiWrapper
