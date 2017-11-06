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
      it "can get the initial search page (recipes 1-10)" do
        keywords = "lemon chicken"
        VCR.use_cassette("recipes") do
          get recipes_search_path, params: keywords
          must_respond_with :success
        end
      end

      it "returns success when recipes match the search term(s) and page parameters are provided" do
        VCR.use_cassette("recipes") do
          @keywords = "lemon chicken"
          get recipes_search_path, params: @keywords
          # params[:keywords] = "lemon chicken"
          # params[:from] = 30
          # params[:to] = 39
          get search_by_page_path(keywords: @keywords, from: 30, to: 39)
          must_respond_with :success
        end
      end
    end
  end
# end
