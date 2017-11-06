require "test_helper"

describe RecipesController do
  describe "root" do
    it "succeeds" do
      get root_path
      must_respond_with :success
    end

  end

  describe "index" do
    it "succeeds when there are recipes for search" do
      query = "apple"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal false
        get recipes_path(query: query)
        must_respond_with :success
      end
    end

    it "redirects when no results available" do
      query = "zzzzmmmaaakkkksss"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal true
        get recipes_path(query: query)
        must_redirect_to root_path
        flash[:message].must_equal "No recipes found, please try again."
      end
    end
  end
end
