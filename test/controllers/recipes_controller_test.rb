require "test_helper"
#
describe RecipesController do
  describe "index" do
    it "returns success to access the index page" do # our home page
      get root_path

      must_respond_with :success
    end # it returns success
  end # end of index

  describe "results" do
    it "returns success if found results" do
      q = "cheese"
      VCR.use_cassette("search") do
        EdamamApiMuncher.search(q, 10, 20).empty?.must_equal false
        get results_path(q: q)
        must_respond_with :success
      end
    end # end of it


    it "redirects if search is invalid" do
      q = ""
      VCR.use_cassette("search") do
        EdamamApiMuncher.search(q, 0, 10).empty?.must_equal true
        get results_path(q: q)
        must_redirect_to root_path
        flash[:message].must_equal "Please enter a search word"
      end
    end
  end
end # end of MunchersController
