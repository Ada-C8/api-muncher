require "test_helper"

# class RecipesControllerTest < ActionDispatch::IntegrationTest

  describe RecipesController do

    describe "index/home page" do
      it "returns success when trying to access the home page" do
        get root_path
        must_respond_with :success
      end
    end

    describe "search" do
      it "can get the initial search results page" do
        @keywords = "lemon chicken"
        VCR.use_cassette("recipes") do
          get recipes_search_path params:{keywords: "lemon chicken"}
          must_respond_with :success
        end
      end

      it "redirects to the home page if the user enters "
    end

    describe "search by page (i.e. pagination)" do
      it "returns success when passed a keyword and recipe numbers (from, to)" do
        VCR.use_cassette("recipes") do
          get recipes_search_path params:{keywords: "lemon chicken", from: 30, to: 39}
          must_respond_with :success
        end
      end
    end
  end
# end
