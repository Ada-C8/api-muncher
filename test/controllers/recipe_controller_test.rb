require "test_helper"

describe RecipeController do
  describe "LIST_SEARCH" do
    it "Can get a list of recipes" do
      VCR.use_cassette("recipecontroller_list_search") do
        get recipes_path, params: { q: "Cheese", page: "2" }
        must_respond_with :success
      end
    end

    it "Gives message and redirects if no path is found or no search results" do
      VCR.use_cassette("recipecontroller_list_search") do
        get recipes_path("bilitong") #at time of testing, no recipes found
        flash[:status].must_equal :failure
        must_respond_with :see_other
      end
    end
  end

  describe "SHOW" do
    it "should display a recipe if the uri exists" do
      VCR.use_cassette("recipecontroller_show") do
        a_recipe_mini_uri = "637913ec61d9da69eb451818c3293df2" #First result when searching api for chicken
        get show_recipe_path(a_recipe_mini_uri)
        must_respond_with :success
      end
    end

    it "WHAT SHOULD IT DO IF IT DOESNT" do
      VCR.use_cassette("recipecontroller_show") do
        a_recipe_mini_uri = "BOGUS"
        get show_recipe_path(a_recipe_mini_uri)
        flash[:status].must_equal :failure
        must_respond_with :see_other
      end
    end
  end

end
