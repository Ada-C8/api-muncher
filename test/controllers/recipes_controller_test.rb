require "test_helper"

describe RecipesController do
  describe "root" do
    it "succeeds" do
      get root_path
      must_respond_with :success
    end

  end

  describe "index" do
    it "succeeds when there are recipes" do
      query = "chicken"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal false
        get recipes_path(query: query)
        must_respond_with :success
      end
    end

    it "renders an empty search page when no results" do
      query = "lkuguyfyrd"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal true
        get recipes_path(query: query)
        must_respond_with :bad_request
      end
    end

    it "redirects when the input is invalid" do
      query = "lkug%&#uyfyrd"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal true
        get recipes_path(query: query)
        must_redirect_to root_path
        flash[:message].must_equal "Invalid input: please try again without symobls."
      end
    end
  end

  describe "show" do
    before do
      @uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f77adf7b01a1f61cbb2fa0d6b290af60"
    end

    it "succeeds when the recipe exists" do
      VCR.use_cassette("find_recipe") do
        recipe = EdamamApiWrapper.find_recipe(@uri)
        recipe.must_be_kind_of Recipe
        get recipe_path(recipe.name, recipe_id: @uri)
        must_respond_with :success
      end
    end

    it "renders 404 not_found for an invalid recipe id" do
      VCR.use_cassette("find_recipe") do
        recipe = EdamamApiWrapper.find_recipe(@uri + "lalala")
        recipe.must_equal nil
        get recipe_path("name", recipe_id: @uri + "lalala")
        must_respond_with :not_found
      end
    end

  end
end
