require "test_helper"

describe RecipesController do
  describe "search method" do
    it "can get the search page" do
    get recipes_search_path
    must_respond_with :success
    end
  end
end
