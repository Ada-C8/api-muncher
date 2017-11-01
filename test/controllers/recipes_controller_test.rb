require "test_helper"

describe RecipesController do
  describe "index" do
    it "must have a main (search) page" do
      get root_path
      must_respond_with :success
    end

    it "must get an index without a search term" do
      get recipes_path
      must_respond_with :success
    end

    it "must get an index path when provided with a search term" do

    end

    it "must respond with not_found if a search term has no results" do

    end
  end
  describe "show" do
    it "must show a user the details for a recipe" do
      get recipe_path(something)
      must_respond_with :success
    end

    it "must respond with not_found if a recipe doesn't exist" do

    end

  end

end
