require 'test_helper'

describe EdamamApiWrapper do
  describe "search" do
    it "can get a list of all recipes" do
      VCR.use_cassette("recipes") do # This can be named whatever we want and it will create a YML recipe file in the fixtures folder
        response = EdamamApiWrapper.search("chicken")
        response.must_be_kind_of Array
        response.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
        response.length.must_be :>, 0
      end
    end

    it "raises an ApiError when the app_id and app_key is bad" do
      VCR.use_cassette("bad_tokens") do
        proc {
          EdamamApiWrapper.search("chicken", "invalid_app_id", "invalid_app_key")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end

  describe "find_recipe" do
    it "can return data of a single recipe" do
      # Get a single recipe and then apps in the uri_id of that instance
      VCR.use_cassette("recipe") do
        all_recipes = EdamamApiWrapper.search("chicken")
        recipe = all_recipes[0]
        recipe_data = EdamamApiWrapper.find_recipe(recipe.uri_id)
        recipe_data.must_be_kind_of Recipe
      end
    end

    it "raises an ArgumentError with a bad uri" do
      VCR.use_cassette("bad_uri") do
        proc { EdamamApiWrapper.find_recipe("BadURI") }.must_raise ArgumentError
      end
    end
  end
end
