require "test_helper"

describe RecipesController do

  # Testing tidbits/ideas/pseudo start.  Think of more tests.  

  describe "HomePage" do
    it "Must get Home page" do
      get recipes_index_url
      value(response).must_be :success?
    end

    it "Must get any available results" do
      get recipes_index_url
      value(response).must_be :success?
    end
  end

  describe "Show" do

    it "Shows a recipe page for a recipe" do
      get recipes_show_url
      value(response).must_be :success?
    end

    it "Error rendered if no recipe found" do
      get recipes_show_url
      value(response).must_be :success?
    end
  end
end
