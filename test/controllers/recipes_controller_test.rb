require "test_helper"

describe RecipesController do

  # Testing tidbits/ideas/pseudo start.  Think of more tests.

  describe "Home Page" do
    it "Must get Home Page." do
      get recipes_index_url
      value(response).must_be :success?
    end

    # Needs work
    it "Must get all availabe results." do
      VCR.use_cassette("recipes") do
        get root_path("cheese")
        must_respond_with :success
      end
    end
  end

  describe "Show" do

    it "Shows a recipe page for a recipe." do
      VCR.use_cassette("recipes") do
        recipe = "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_c23d4d64e02318eef70940c6643353ad"
        get root_path(recipe: recipe)
        must_respond_with :success
      end
    end

    it "Error rendered if no recipe found." do

      VCR.use_cassette("recipes") do

        get recipe_path()

        must_respond_with
      end
    end
  end
end
