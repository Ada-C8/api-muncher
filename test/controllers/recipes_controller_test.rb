require 'test_helper'
require 'pry'

describe RecipesController do

  describe "index" do
    it "returns success" do
      get root_path
      must_respond_with :success
    end

    it "returns an array of recipes" do
      VCR.use_cassette("recipes") do
        get root_path, params: { search: "cheese", from: 10 }
        must_respond_with :success
      end
    end

    it "will return an array of recipes when the from parameter is not given" do
      VCR.use_cassette("recipes") do
        get root_path, params: { search: "chicken"}
        must_respond_with :success
      end
    end
  end

  describe "show" do

    it "Will return success when valud uri/id is given" do
      VCR.use_cassette("recipes") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        get recipes_path, params: {id: uri}
        must_respond_with :success
      end
    end

    it "Will return a 404 if valid uri is not given" do
      VCR.use_cassette("recipes") do
        bad_uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7d"
        get recipes_path, params: {id: bad_uri}
        must_respond_with :not_found
      end
    end
  end

end

# it "will return a bad request when no uri is given"
# returns bad request when no uri given
