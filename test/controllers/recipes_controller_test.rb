require "test_helper"

describe RecipesController do
  describe "#home" do
    it "successfully loads home page" do
      get root_path
      must_respond_with :success
    end

    it "stays on home page if search term is an empty string" do
      VCR.use_cassette("recipes") do
        get root_path(search: "")
        must_respond_with :success
      end

      VCR.use_cassette("recipes") do
        get root_path(search: "          ")
        must_respond_with :success
      end
    end
  end

  describe "#index" do

    it "successfully loads search results for any search term" do

      VCR.use_cassette("recipes") do
        get recipes_path(search: "chicken")
        must_respond_with :success
      end

      VCR.use_cassette("recipes") do
        get recipes_path(search: "%")
        must_respond_with :success
      end
    end

    it "redirects to root_path if search term is blank" do
      VCR.use_cassette("recipes") do
        get recipes_path(search: "  ")
        flash.keys.must_include "error"
        must_redirect_to root_path
      end
    end
  end

  describe "#show" do

    it "shows a recipe page" do
      VCR.use_cassette("recipes") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        get recipe_path(id: "recipe_label", uri: uri )
        must_respond_with :success
      end
    end

    it "renders 404 if the recipe page is not found" do
      VCR.use_cassette("recipes") do
        invalid_uri = "7bf4a371c6884d809682a72808da7dc2"

        get recipe_path(id: "recipe_label", uri: invalid_uri)

        must_respond_with :missing
      end
    end

  end
end
