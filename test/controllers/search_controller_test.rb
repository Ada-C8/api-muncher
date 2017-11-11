require 'test_helper'

describe SearchController do
  describe "create / find recipes" do
    it "succeeds getting to root path" do
      get root_path
      must_respond_with :success
    end

    it "succeeds for the create action to generate search results for popular query" do
      VCR.use_cassette("list_all") do
        get search_results_path(params: {ingredients: "chicken"})
        must_respond_with :success
      end
    end

    it "redirects if not given ingredients" do
      VCR.use_cassette("list_all") do
        get search_results_path
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end

    it "succeeds for the create action to generate search results for longer query" do
      VCR.use_cassette("list_all") do
        get search_results_path(params: {ingredients: "chicken, lemon, balsamic"})
        must_respond_with :success
      end
    end

    it "succeeds for a search with no results" do
      VCR.use_cassette("list_all") do
        get search_results_path(params: {ingredients: "vampires, turantulas, glass, bats, cats"})
        must_respond_with :success
      end
    end
  end

  describe "show recipe" do
    it "succeeds in showing information about a single recipe" do
      VCR.use_cassette("list_another_one") do
        get search_results_path(params: {ingredients: "lemon"})
        get show_recipe_path("Lemon Sorbet", uri: "http://www.edamam.com/ontologies/edamam.owl%23recipe_88f6c6167b43fe6754446675fe4e1945")
        must_respond_with :success
      end
    end

    it "redirects if given a bogus uri" do
      VCR.use_cassette("fake_data") do
        get search_results_path(params: {ingredients: "lemon"})
        get show_recipe_path("Lemon Sorbet", uri: "http://www.edamam.com/ontologies/edamam.owl%fake")
        must_respond_with :redirect
      end
    end
  end
end
