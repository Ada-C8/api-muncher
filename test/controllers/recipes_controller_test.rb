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

    it "redirects when the search fails" do
      query = "lkuguyfyrd"
      VCR.use_cassette("search") do
        EdamamApiWrapper.search(query).empty?.must_equal true
        get recipes_path(query: query)
        must_redirect_to root_path
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

    # it "redirects when the search fails" do
      # VCR.use_cassette("show") do
      #   recipe = EdamamApiWrapper.find_recipe(@uri + "lalala")
      #   recipe.must_equal ""
      #   get recipe_path(recipe.name)
      #   must_respond_with :success
      # end
      # how to test this?
    # end
  end
end
