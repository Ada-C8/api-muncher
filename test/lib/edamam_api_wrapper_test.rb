require 'test_helper'

describe EdamamApiWrapper do

  describe ".list_recipes" do

    it "can get a list of recipes" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("mushroom pizza")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end
    it "returns [] for a bad request" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("")

        recipes.must_equal []
      end

      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("mushroom pizza", "Bogus ID")

        recipes.must_equal []
      end

      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("mushroom pizza", nil, "Bogus Key")

        recipes.must_equal []
      end
    end
  end
end
