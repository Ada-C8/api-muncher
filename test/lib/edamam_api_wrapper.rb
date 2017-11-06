require 'test_helper'

describe EdamamApiWrapper do

  describe "search" do
    it "can list recipes matching a search query" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.search("chicken")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "will return [] for a broken request" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.search()

        recipes.must_be_instance_of Array
        recipes.must_equal []
      end
    end
  end

  describe "find_recipe" do
    it "retrieves a single recipe by uri" do
      VCR.use_cassette("find_recipe") do
        recipe = EdamamApiWrapper.find_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2")

        recipe.must_be_instance_of Array
        recipe.length.must_equal 1
        recipe[0].must_be_instance_of Recipe
      end
    end

    it "returns an empty array if no recipe is found" do
      VCR.use_cassette("find_recipe") do
        recipe = EdamamApiWrapper.find_recipe("bogus")

        recipe.must_be_instance_of Array
        recipe.must_equal []
      end
    end
  end
end
