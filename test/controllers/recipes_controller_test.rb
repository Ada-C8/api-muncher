require "test_helper"

describe RecipesController do
  describe "root" do
    it "should return a success status" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "should return a status success when given valid data" do
      VCR.use_cassette("apple") do
        q = {
          q: "apple"
        }

        get recipes_path, params: q
        must_respond_with :success
      end
    end

    #TODO: how to set bad key/id when you don't ever get this from the params?
    it "should set flash[:status] to :failure and redirect_back if given invalid data" do
      VCR.use_cassette("apple") do
        params = {
          q: "apple",
          # app_id: "",
          # app_key: ""
        }

        get recipes_path, params: params
        must_respond_with :redirect
      end
    end

    it "should set flash[:status] to :failure and redirect if there are no recipes" do
      VCR.use_cassette("norecipes") do
        q = {
          q: ""
        }

        get recipes_path, params: q
        flash[:status].must_equal :failure
        must_respond_with :redirect
      end
    end
  end

  describe "show" do
    it "should return a status success when given valid data" do
      VCR.use_cassette("apple") do
        recipes = EdamamApiWrapper.search("apple")
        id = recipes[0].uri_id

        get recipe_path(id)
        must_respond_with :success
      end
    end

    it "should set flash[:status] to :failure and redirect_back if given invalid data" do
      VCR.use_cassette("no_recipe") do
      	get recipe_path("Not a valid uri")

      	flash[:status].must_equal :failure
      	must_respond_with :redirect
      end
    end
  end
end
