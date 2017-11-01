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
    it "returns recipe when given a valid URI" do
      VCR.use_cassette("productive_show") do
        uris = ["http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"]

        uris.each do |uri|
          recipe = FoodApiWrapper.show_recipe(uri)
            recipe.must_be_instance_of Recipe
        end
      end
    end

    it "returns an empty array when given an invalid URI" do
      VCR.use_cassette("unproductive_show") do
        uris = ["beepblopbloopthiswontworkhahahaha", ""]

        uris.each do |uri|
          recipes = FoodApiWrapper.show_recipe(uri)
          recipes.must_equal nil
        end
      end
    end
  end
end
