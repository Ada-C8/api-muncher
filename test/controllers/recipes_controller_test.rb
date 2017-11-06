require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest

  describe "index" do
    it "can get a list of recipe search results" do
      VCR.use_cassette("index_action") do
        get recipes_path
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "can get a specific recipe" do
      VCR.use_cassette("show_action") do
        get recipe_path
        must_respond_with :success
      end
    end
  end

end
