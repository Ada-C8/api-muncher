require 'test_helper'

describe EdamamApiWrapper do

  describe "self.list_recipes" do

    it "can get a list of recipes" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("pizza")

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
        recipes = EdamamApiWrapper.list_recipes("pizza", "Bogus ID")

        recipes.must_equal []
      end

      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("pizza", nil, "Bogus Key")

        recipes.must_equal []
      end
    end
  end

  describe 'self.show_recipe' do
    it 'can get a single recipe object' do
      VCR.use_cassette("recipes") do
        recipe = EdamamApiWrapper.show_recipe("pizza", "http://www.marthastewart.com/284463/pizza-frizza")

        recipe.must_be_instance_of Recipe
      end
    end
    it 'returns nil if recipes array is empty after search' do
      VCR.use_cassette("recipes") do
        recipe = EdamamApiWrapper.show_recipe("tacos are not pizza", "http://www.marthastewart.com/284463/pizza-frizza")

        recipe.must_be_nil
      end
    end
    it 'returns nil for a url not found inside the recipes array' do
      VCR.use_cassette("recipes") do
        recipe = EdamamApiWrapper.show_recipe("pizza", "oh-look-its-a-fake-url")

        recipe.must_be_nil
      end
    end
  end
end
