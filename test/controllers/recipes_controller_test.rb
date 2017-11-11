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

    it "should set flash[:status] to :failure and redirect_back if given invalid data" do
      VCR.use_cassette("no_id") do
        q = {
          q: "apple",
        }

        get recipes_path, params: q
        flash[:status].must_equal :failure
        must_respond_with :redirect
      end
    end

    it "should set flash[:status] to :failure and redirect_back if given an empty search" do
      VCR.use_cassette("empty_string_search") do
        q = {
          q: "",
        }

        get recipes_path, params: q
        flash[:status].must_equal :failure
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

# Test that using paging params gives different results (or at least that it works)
# What if the paging parameters are invalid (negative number, etc)?
# What if the paging parameters take you past the end of the available search results?

    it "should return 12 recipes when per_page is set to 12" do
      VCR.use_cassette("paginate_12") do
        q = {
          q: "pasta"
        }

        get recipes_path, params: q

      end
    end

    it "should return 0 recipes when per_page is set to a negative number" do
      VCR.use_cassette("paginate_negative") do
        q = {
          q: "pasta"
        }

        get recipes_path, params: q

      end
    end

    t "should return all recipes when per_page is set to a number that is larger than the number of recipe results" do
      VCR.use_cassette("paginate_big_num") do
        q = {
          q: "pasta"
        }

        get recipes_path, params: q

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
