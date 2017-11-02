require "test_helper"

describe RecipesController do

  describe "home" do
    it "can get the home page" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    let(:ingredient) { "chicken" }

    it "responds with success if it returns results" do
      VCR.use_cassette("index_action") do
        get recipes_path params: { ingredient: ingredient }
        must_respond_with :success
      end
    end

    it "responds with success if it returns 0 results" do
      VCR.use_cassette("index_action") do
        get recipes_path params: { ingredient: "jlk" }
        must_respond_with :success
      end
    end

  end

  describe "show" do
    let(:valid_uri) { "http://www.edamam.com/ontologies/edamam.owl%23recipe_6289468ceb188ec8103d4a0c4adab6b8"}

    it "responds with success if the recipe exists" do
      VCR.use_cassette("show_action") do
        get recipe_path("valid recipe"), params: { uri: valid_uri }
        must_respond_with :success
      end
    end

    it "responds with not found if the recipe doesn't exist" do
      VCR.use_cassette("show_action") do
        get recipe_path("invalid recipe"), params: { uri: "https://www.fake.com" }
        must_respond_with :not_found
      end
    end
  end

end
