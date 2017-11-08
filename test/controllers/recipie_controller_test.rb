require 'test_helper'

describe RecipesController do
  describe "index" do
    it "can return list of matching recipes" do
     VCR.use_cassette("index_action") do
       get root_path
       must_respond_with :success
     end
   end
  end

  describe "results" do
    it "must returns with success" do
      VCR.use_cassette("results_action") do
        params = {
          q: "chicken",
          from: 0
        }
        get  get_recipes_path, params: params
        must_respond_with :success
      end
    end

    it "returns blank array when query not found" do
      VCR.use_cassette("results_action") do
        params = {
          q: "lasjdlkfasjdf",
          from: 0
        }
        get  get_recipes_path, params: params
        must_respond_with :success
      end
    end

    it "message is dispalyed if query is blank" do
      VCR.use_cassette("results_action") do
        params = {
          from: 0
        }
        get  get_recipes_path, params: params
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "must returns with success" do
      VCR.use_cassette("show_action") do
        get show_recipe_path("recipe_5264be9d66d1276ce4c5f5f97260235d")
        must_respond_with :success
      end
    end

    it "must returns with success for bad query" do
      VCR.use_cassette("show_action") do
        get  show_recipe_path("garbage")
        must_respond_with :success
      end
    end
  end

end
