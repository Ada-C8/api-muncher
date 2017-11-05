require "test_helper"

describe RecipeController do
  it "successfully pulls up the home screen" do
    get root_path

    must_respond_with :success
  end

  describe "index" do

    it "pulls up a page with search results" do
      VCR.use_cassette("index_action") do
        search_term = "asparagus"

        get recipe_results_path, params: {search: search_term}

        must_respond_with :success
      end
    end

    it "flashes a failure message and redirects to the root_path if no search term is entered" do
      VCR.use_cassette("index_action") do
        search_term = ""

        get recipe_results_path, params: {search: search_term}

        must_redirect_to root_path
        flash[:failure].must_equal "No search term entered"
      end

    end

    it "pulls up the index page even when no matching recipes are found" do
      VCR.use_cassette("index_action") do
        search_term = "totallyridonkulous"

        get recipe_results_path, params: {search: search_term}

        must_respond_with :success
      end

    end

  end

  describe "show" do
    it "successfully pulls up a show page for a valid recipe result" do
      VCR.use_cassette("show_action") do
        search_term = "asparagus"

        results = EdamamApiWrapper.search_recipe_results(search_term)

        valid_recipe = results.first

        get show_recipe_path(valid_recipe), params: {uri: valid_recipe.uri}

        must_respond_with :success
      end

    end

    it "flashes a failure message and renders the 404 page if the recipe does not exist" do
      VCR.use_cassette("show_action") do
        bad_uri = "http://nonexistinguri.com"

        get show_recipe_path("invalid_recipe"), params: {uri: bad_uri}

        must_redirect_to root_path
        flash[:failure].must_equal "This recipe does not exist"
      end
    end

    it "renders 404 if no recipe uri is passed" do
      VCR.use_cassette("show_action") do
        get show_recipe_path("invalid_recipe")


        must_redirect_to root_path
        flash[:failure].must_equal "This recipe does not exist"

      end

    end

  end
end
