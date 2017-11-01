require "test_helper"

describe RecipesController do
  describe "index" do
    it "works with a search that gets hits" do
      VCR.use_cassette("recipes") do
        get recipes_path, params: { search: "pizza"}

        must_respond_with :success
      end
    end
    it "works with a search that doesn't get hits" do
      VCR.use_cassette("recipes") do
        get recipes_path, params: { search: "blorgadybloop"}

        must_respond_with :success
      end
    end
  end
  describe "show" do
    it "can get a recipe object" do
      VCR.use_cassette("recipes") do
        get recipe_path, params: { search: "pizza mushroom", url: "http://www.marthastewart.com/875377/leek-mushroom-and-prosciutto-pizza"}

        must_respond_with :success
      end
    end
  end
end
