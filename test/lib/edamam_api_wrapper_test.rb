require 'test_helper'

describe EdamamApiWrapper do
  describe "self.search" do
    it "returns a list of Recipes" do
      VCR.use_cassette("wrapper_search") do
        recipes = EdamamApiWrapper.search("pineapple")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end

        recipes = EdamamApiWrapper.search("pineapple", "low-fat")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end

        recipes = EdamamApiWrapper.search("", "low-fat")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "returns a blank array if no recipes are found or the request is broken" do
      VCR.use_cassette("wrapper_search") do

        recipes = EdamamApiWrapper.search("")

        recipes.must_be_instance_of Array
        recipes.must_equal []

        recipes = EdamamApiWrapper.search("chicken", "low-fat", app_id: "")

        recipes.must_be_instance_of Array
        recipes.must_equal []

        recipes = EdamamApiWrapper.search("chicken", "low-fat", app_key: "")

        recipes.must_be_instance_of Array
        recipes.must_equal []
      end
    end

    it "returns a default number of results (or less) or the amount specified" do
      VCR.use_cassette("wrapper_search") do
        recipes = EdamamApiWrapper.search("chicken")
        recipes.length.must_equal EdamamApiWrapper::MAX_SEARCH_LENGTH

        recipes = EdamamApiWrapper.search("chicken and soysauce")
        recipes.length.must_be :<=, EdamamApiWrapper::MAX_SEARCH_LENGTH

        recipes = EdamamApiWrapper.search("chicken", "low-fat", to: 4)
        recipes.length.must_equal 4

        recipes = EdamamApiWrapper.search("chicken", "low-fat", from: 15, to: 20)
        recipes.length.must_equal 5
      end
    end
  end #self.search

  describe "self.find_recipe" do
    it "returns a single recipe" do
      VCR.use_cassette("wrapper_find_recipe") do
        recipe = EdamamApiWrapper.search("pineapple").first
        new_recipe = EdamamApiWrapper.find_recipe(recipe.uri_hash)

        new_recipe.must_be_instance_of Recipe
        new_recipe.must_equal recipe
      end
    end

    it "returns nil if no recipe is found or the request is broken" do
      VCR.use_cassette("wrapper_find_recipe") do
        recipe = EdamamApiWrapper.find_recipe("")
        recipe.must_be_nil

        recipe = EdamamApiWrapper.search("pineapple").first
        new_recipe = EdamamApiWrapper.find_recipe(recipe.uri_hash, app_id: "BOGUS")
        new_recipe.must_be_nil

        new_recipe = EdamamApiWrapper.find_recipe(recipe.uri_hash, app_key: "BOGUS")
        new_recipe.must_be_nil

      end
    end #self.find_recipe

    describe "self.complete?" do
      it "returns false if any of the minimum keys aren't found" do
        hash = {
          "uri" => "some_url",
          "image" => "some_url",
          "ingredientLines" => ["stuff"]
        }

        EdamamApiWrapper.complete?(hash).must_equal false
      end
    end

    it "returns true if all minimum keys are present" do
      hash = {
        "label" => "something",
        "uri" => "some_url",
        "image" => "some_url",
        "ingredientLines" => ["stuff"]
      }

      EdamamApiWrapper.complete?(hash).must_equal true
    end
  end #self.complete?
end
