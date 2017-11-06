require "test_helper"
require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

describe RecipesController do

  describe "index" do
    it "must redirect if given an empty search" do
      input = {
        q: ""
      }
      get recipes_path, params: input

      flash[:status].must_equal :failure
      flash[:message].must_equal "You must enter a search term"
    end

    it "must return success flash message if given a search term" do
      VCR.use_cassette("recipes_search") do
        get recipes_path("chicken")
        flash[:status].must_equal :success
        flash[:message].must_equal "successfully searched"
      end
    end

    it "must return success flash message and relevant recipes if given a search term and health filters" do
      VCR.use_cassette("recipes_search_with_filters") do
        search = {
          q: "cookies",
          vegan: "1",
          peanut_free: "1",
          tree_nut_free: "1",
          vegetarian: "1",
          alcohol_free: "1",
          low_fat: "1",
          sugar_conscious: "1"
        }

        get recipes_path, params: search

        flash[:status].must_equal :success
        flash[:message].must_equal "successfully searched"

      end
    end
  end

  describe "show" do

    it "must return success flash message if given a valid uri id" do
      VCR.use_cassette("valid_uri") do
        valid_uri = "637913ec61d9da69eb451818c3293df2"
        get recipe_path(valid_uri)

        flash[:status].must_equal :success
        flash[:message].must_equal "Successfully found recipe"
      end
    end

    it "must return failure flash message and redirect if given an invalid uri id" do
      VCR.use_cassette("invalid_uri") do
        invalid_uri = "invaliduri"
        get recipe_path(invalid_uri)

        flash[:status].must_equal :failure
        flash[:message].must_equal "You must enter a valid uri id"
      end
    end


  end
end
