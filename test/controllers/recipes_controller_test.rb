require "test_helper"

describe RecipesController do
  it "Should get root path." do
    get root_path
    must_respond_with :success
  end

  describe "Index" do
    it "Must get all availabe results." do
      VCR.use_cassette("recipes") do
        get recipes_index_path, params: {search: "cheese"}
        must_respond_with :success
      end
    end

    it "Should redirect to root path if no search results are found." do
      VCR.use_cassette("recipes") do
        get recipes_path, params: {search: "nomanomanomanom"}
        must_redirect_to root_path
      end
    end
  end

  describe "Show" do
    it "Shows a recipe page for a recipe." do
      VCR.use_cassette("recipes") do
        recipe = "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_c23d4d64e02318eef70940c6643353ad"
        get recipe_path(uri: recipe)
        must_respond_with :success
      end
    end

    it "404 error rendered if no recipe is found." do
      VCR.use_cassette("recipes") do
        invalid_id = "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23notarealthing"
        get recipe_path(uri: invalid_id)
        must_respond_with :not_found
      end
    end
  end
end
