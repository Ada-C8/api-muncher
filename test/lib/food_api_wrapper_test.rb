require 'test_helper'

describe FoodApiWrapper do
  describe "find_recipes" do
    it "can find a list of recipes by search term" do
      VCR.use_cassette("productive_search") do
        search_terms = ["chicken", "bananas", "pumpkin pie"]

        search_terms.each do |term|
          recipes = FoodApiWrapper.find_recipes(term)

          recipes.must_be_instance_of Array
          recipes.each do |recipe|
            recipe.must_be_instance_of Recipe
          end
        end
      end
    end

    it "will return an empty array for an empty or nil search string" do
      VCR.use_cassette("unproductive_search") do
        search = ["", nil]

        search.each do |term|
          recipes = FoodApiWrapper.find_recipes(term)
          recipes.must_be_instance_of Array
          recipes.must_equal []
        end
      end
    end
  end

  describe "show_recipe" do
    it "can find a recipe when given a valid URI" do

    end

    it "returns an empty array when given an invalid URI" do

    end

  end
end
