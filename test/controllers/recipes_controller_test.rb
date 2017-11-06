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
end
