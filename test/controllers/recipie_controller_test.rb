require 'test_helper'

describe RecipesController do
  describe "index" do
    it "must returns with success" do
      get root_path
      must_respond_with :success
    end
  end

  describe "results" do
    it "must returns with success" do
      params = {
        q: "chicken",
        from: 0
      }
      get  get_recipes_path, params: params
      must_respond_with :success
    end

    it "returns blank array when query not found" do
      params = {
        q: "lasjdlkfasjdf",
        from: 0
      }
      get  get_recipes_path, params: params
      must_respond_with :success
    end
  end

  describe "show" do
    it "must returns with success" do
      get  show_recipe_path("recipe_5264be9d66d1276ce4c5f5f97260235d")
      must_respond_with :success
    end
  end
end
