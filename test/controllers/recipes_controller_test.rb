require "test_helper"

describe RecipesController do
  describe "index" do
    it "must have a main (search) page" do
      VCR.use_cassette("index_test") do
        get root_path
        must_respond_with :success
      end
    end

    it "must get an empty index without a search term or if a search has no results" do
      VCR.use_cassette("index_test") do
        get recipes_path, params: {term: ""}
        must_respond_with :success
      end
    end

    it "must get an index path when provided with a search term" do
      VCR.use_cassette("index_test") do
        get recipes_path, params: {term: "chicken"}
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "must show a user the details for a recipe" do
      VCR.use_cassette("show_test") do
        recipe = FoodApiWrapper.find_recipes("chicken").first
        get recipe_path(recipe.name), params: {uri: recipe.uri}
        must_respond_with :success
      end
    end

    it "must respond with not_found if a recipe doesn't exist" do
      VCR.use_cassette("show_test") do
        get recipe_path("faulty test"), params: {uri: "baduri"}
        must_respond_with :not_found
      end
    end
  end
end
