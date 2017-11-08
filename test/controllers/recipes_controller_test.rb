require 'test_helper'

# class RecipesControllerTest < ActionDispatch::IntegrationTest
describe RecipesController do

  describe "INDEX" do
    it "Can get to the home index" do
      VCR.use_cassette("index_action") do

        get root_path

        must_respond_with :success
      end
    end

    it "Can get a list of recipes" do
      VCR.use_cassette("index_action") do

        ingredient = "chicken"

        get recipes_path, params:{search: ingredient}

        must_respond_with :success
      end
    end

  end

  describe "SHOW" do
    it "Can get to an individual recipe " do
      VCR.use_cassette("show_action") do

        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"

        get recipe_path("name"), params:{uri: uri}

        must_respond_with :success
      end
    end
  end


end
