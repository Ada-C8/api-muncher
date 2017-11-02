require "test_helper"

describe RecipesController do
  describe "index" do
    it "can get a list of recipes" do
      # VCR.use_cassette("index_action") do
      #   get root_path
      #   must_respond_with :success
      #
      #   @recipes.must_be_instance_of Array
      #   @recipes.each do |recipe|
      #     recipe.must_be_instance_of Recipe
      #   end
      # end
    end

    it "defualts a list of recipes if a search is not done before" do
      # VCR.use_cassette("index_action") do
      #
      #
      # end
    end

    it "successfully loads page with many recipes" do


    end

    it "loads page with no recipes" do


    end

    it "loads page with a request with no recipes" do


    end
  end

  describe "show" do
    it "finds a recipe and loads the page" do
      # VCR.use_cassette("show_action") do
      #   get recipe_path( )
      #   @recipe.must_be_instance_of Recipe
      #   must_respond_with :success
      # end
    end

    it "renders a 404 if the recipe is not found" do
      # VCR.use_cassette("show_action") do
      #   get recipe_path("Bogus")
      #   must_respond_with :not_found
      # end
    end
  end
end
