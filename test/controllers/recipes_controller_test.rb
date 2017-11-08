require "test_helper"

describe RecipesController do
  it "Should get root path." do
    get root_path
    must_respond_with :success
  end

  describe "Index" do
    it "Must get all available results." do
      VCR.use_cassette("recipes") do
        get recipes_index_path, params: {search_word: "cheese"}
        must_respond_with :success
      end
    end

    it "Should redirect to root path if no search results are found." do
      VCR.use_cassette("recipes") do
        get recipes_index_path, params: {search_word: "ksdlfjalsjkjlkjdf"}
        must_redirect_to root_path
      end
    end

    it "Should redirect to root path if search word is provided." do
      VCR.use_cassette("recipes") do
        get recipes_index_path
        must_redirect_to root_path
      end
    end

  end

  describe "Show" do
    it "Shows a recipe page for a recipe." do
      VCR.use_cassette("recipes") do
        recipe = "c23d4d64e02318eef70940c6643353ad"
        get recipe_path(recipe)
        must_respond_with :success
      end
    end

    it "404 error rendered if no recipe is found." do
      VCR.use_cassette("recipes") do
        invalid_id = "notarealthing"
        get recipe_path(invalid_id)
        must_respond_with :not_found
      end
    end
  end
end
