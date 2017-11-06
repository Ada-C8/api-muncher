require "test_helper"

describe RecipesController do

  describe "search" do
    it "can display the search form" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "displays a list of recipes for a valid query" do
      VCR.use_cassette("ok_query_recipe_index") do
        get recipes_path, params: {query: "chicken"}
        must_respond_with :success
      end
    end

    it "displays an empty index if the query yields no results" do
      VCR.use_cassette("bad_query_recipe_index") do
        get recipes_path, params: {query: "as;fj;alkfjsdlfkdsa;fkjsd;fkjasfl;kjaflkjs"}
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "can display the show page for a valid recipe from a query" do
      VCR.use_cassette("ok_uri_recipe_show")do
        uri = "c5a89acb06b3f1cb35da47c3a070bb43"
        get recipe_path(uri)
        must_respond_with :success
      end
    end

    it "redirects to a 404 page if the recipe uri is invalid" do
      VCR.use_cassette("bad_uri_recipe_show") do
        get recipe_path("bad_uri")
        must_respond_with :not_found
      end
    end
  end
  
end
