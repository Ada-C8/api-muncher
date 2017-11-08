require 'test_helper'

describe EdamamApiWrapper do
  describe "search_recipes" do
    it "can get a list of recipes" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.search_recipes("fish")
        recipes.must_be_kind_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    # raises ArgumentError instead
    
    # it "raises an ApiError when the credentials are bad" do
    #   VCR.use_cassette("no recipes") do
    #     proc { EdamamApiWrapper.search_recipes("fish", "invalid_app_id", "invalid_app_key") }.must_raise EdamamApiWrapper::ApiError
    #   end
    # end
  end

  describe "show_recipe" do
    it "returns data for a recipe" do
      VCR.use_cassette("recipe") do
        uri = "637913ec61d9da69eb451818c3293df2"
        recipe = EdamamApiWrapper.show_recipe(uri)
        recipe.must_be_kind_of Recipe
      end
    end

    it "raises an ApiError when invalid id" do
      VCR.use_cassette("not_found") do
        uri = "invalid_id"
        proc { EdamamApiWrapper.show_recipe(uri) }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end
end
