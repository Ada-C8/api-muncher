require "test_helper"
#
describe RecipesController do
  describe "index" do
    it "returns success to access the index page" do # our home page
      get root_path

      must_respond_with :success
    end # it block
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
      end # VCR
    end # it block
  end # end of results

  describe "show" do

    it "returns success if given valid uri id" do
      VCR.use_cassette("valid_id") do
        valid_id = "421df807e21c65c842ec62870604aed3"
        get show_path(valid_id)
        flash[:status].must_equal :success
        flash[:message].must_equal "Success, recipe has been found"
      end # VCR
    end # it


    it "returns failure if given invalid id" do
      VCR.use_cassette("invalid_id") do
        invalid_id = "invalid_id"
        get show_path(invalid_id)
        flash[:status].must_equal :failure
        flash[:message].must_equal "Please enter a valid uri id"
      end # VCR
    end # it
  end # describe

end # end of MunchersController
