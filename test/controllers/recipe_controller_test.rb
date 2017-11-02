require "test_helper"

describe RecipeController do
  describe "LIST_SEARCH" do
    it "can get a list of recipes" do
      VCR.use_cassette("recipecontroller_list_search") do
        get recipes_path("cheese")
        must_respond_with :success
      end
    end

    it "WHAT HAPPENS WHEN NO RESULTS" do
      skip
      #flash no results found, stay on search page
      VCR.use_cassette("recipecontroller_list_search") do
        get recipes_path("")
        must_respond_with #?
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
      skip
      #render 404, invalid id
    end
  end

end
