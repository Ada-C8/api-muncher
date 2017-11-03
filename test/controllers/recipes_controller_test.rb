require "test_helper"

describe RecipesController do
  describe "home" do
    it "returns success to access the home page" do
      get root_path

      must_respond_with :success
    end
  end

  describe "index" do
    it "returns success with all recipes" do
      VCR.use_cassette("recipes") do
        input = {
          q: "chicken"
        }

        get recipes_path, params: input

        must_respond_with :success
      end
    end

    it "redirects back if search is blank" do
      input = {
        q: ""
      }

      get recipes_path, params: input

      flash[:status].must_equal :failure
      must_respond_with :redirect
    end

    # TODO: Fix this?
    # it "returns a failure flash if the ApiError is raised due to bad keys" do
    #   VCR.use_cassette("bad_tokens") do
    #     input = {
    #       q: "chicken"
    #     }
    #
    #     proc { get recipes_path, params: input }.must_raise EdamamApiWrapper::ApiError
    #   end
    # end
  end # Des

  describe "show" do
    it "returns success when requesting one recipe" do
      VCR.use_cassette("recipes") do
        all_recipes = EdamamApiWrapper.search("chicken")
        recipe = all_recipes[0]

        get recipe_path(recipe.uri_id)

        must_respond_with :success
      end
    end

    # TODO: How to test a raise in ArgumentError if you rescue it
    it "returns not found when requesting a recipe that is invalid" do
      VCR.use_cassette("no_recipe") do
        get recipe_path("Not a valid uri")

        flash[:status].must_equal :failure
        flash[:message].must_equal "Recipe does not exist!"
        must_respond_with :redirect
      end
    end
  end
end # Des
