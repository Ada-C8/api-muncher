require 'test_helper'
require 'pry'

describe RecipesController do

  describe "index" do
    it "returns success" do
      get root_path
      must_respond_with :success
    end

    it "returns a collection of recipes when from parameter is given" do
      VCR.use_cassette("recipes") do
        get root_path, params: { search: "cheese", from: 10 }
        must_respond_with :success
      end
    end

    it "returns a collection of recipes when from parameter is not given" do
      VCR.use_cassette("recipes") do
        get root_path, params: { search: "cheese" }
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "returns success when a valid uri is given" do
      VCR.use_cassette("specific_recipe") do
        get recipes_path, params: { id: "http://www.edamam.com/ontologies/edamam.owl#recipe_421df807e21c65c842ec62870604aed3" }
        must_respond_with :success
      end
    end

    it "returns not found when an invalid uri is given" do
      VCR.use_cassette("bad_uri_recipe") do
        get recipes_path, params: { id: "http://www.edamam.com/ontologies/edamam.owl#recipe_421df807e21c65c842ec62870604" } #bad uri
        must_respond_with :not_found
      end
    end

    it "returns bad request even when no uri is given" do
      VCR.use_cassette("bad_uri_recipe") do
        get recipes_path #no uri
        must_respond_with :bad_request
      end
    end
  end
end
