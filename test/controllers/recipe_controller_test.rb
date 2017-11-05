require "test_helper"

describe RecipeController do


  describe "show" do
    it "shows a recipe" do
      VCR.use_cassette("recipes") do
        uri ="_7bf4a371c6884d809682a72808da7dc2"
        get recipe_path(uri)
        must_respond_with :success
      end
    end

    # it "does something when there is no recipe" do
    #   VCR.use_cassette("recipes") do
    #     uri ="_bogus"
    #     get recipe_path(uri)
    #   end
    # end
    #I choose not to do this b/c I don't see how this could happen unless someone was typing bad info right into the address bar.
  end


  describe "index" do
    it "returns a list of recipes if there are any related to the search" do
      VCR.use_cassette("recipes") do
        params = {}
        params[:query] = "chicken"
        get recipes_path
        must_respond_with :ok
      end
    end
  end
end
