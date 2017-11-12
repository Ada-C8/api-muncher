require "test_helper"

describe RecipesController do
  describe "root" do
    it "shows a home page, returns success" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "show idex for a search term" do
      VCR.use_cassette("yogurt") do
        test_params = {
          search_term: "yogurt"
        }
        get recipes_path, params: test_params
        must_respond_with :success
      end
    end
  end
  #
  # describe "show" do
  #
  # end
end
