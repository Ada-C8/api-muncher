require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  describe "index" do
    it "can get the list of found recipes" do
      VCR.use_cassette("index_action") do
        get root_path
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "returns the requested recipe" do
      VCR.use_cassette("show_action") do
        get recipe_path("recipe_7bf4a371c6884d809682a72808da7dc2")
        must_respond_with :success
      end
    end

    it "returns an error if it has a bad request" do
      VCR.use_cassette("show_action") do
        get recipe_path("76f4a374d0968272808da7dc2")
        flash[:error].must_equal "Recipe not found"
        must_redirect_to recipes_path
      end
    end
  end


end
