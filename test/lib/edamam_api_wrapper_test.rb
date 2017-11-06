
require 'test_helper'

describe EdamamApiWrapper do
  describe "search" do
    it "Can get an array of recipe objects with a search term" do
      VCR.use_cassette("recipes") do
        result = EdamamApiWrapper.search("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "Can get an array of recipe objects with a search term and health filters" do
      VCR.use_cassette("search_and_health_filter") do
        result = EdamamApiWrapper.search("chicken", {health: ["peanut-free", "tree-nut-free"]})
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
          recipe.health_labels.must_include "Peanut-Free"
          recipe.health_labels.must_include "Tree-Nut-Free"
        end
      end
    end


    it "Raises an ApiError when the tokens are bad" do
      VCR.use_cassette("invalid_tokens") do
        proc {
          EdamamApiWrapper.search("chicken", {health: ["peanut-free"]}, "bogus_token1", "bogus_token2")
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

    it "returns an empty array if recipe is not found" do
      VCR.use_cassette("invalid_find_recipe") do
        invalid_uri = "637913ec61d9da69eb451818c3293d2"
        result = EdamamApiWrapper.find_recipe(invalid_uri)
        result.must_equal []
      end
    end
  end


end
