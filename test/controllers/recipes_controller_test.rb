require "test_helper"

describe RecipesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe "index" do
    it "displays a list of recipes for a valid query" do
      get recipes_path("chicken")
      must_respond_with :success
    end

    it "redirects to not_found if the query is invalid" do
      get recipes_path("as;fj;alkfjsdlfkdsa;fkjsd;fkjasfl;kjaflkjs")
      must_respond_with :redirect
    end
    
  end
end
