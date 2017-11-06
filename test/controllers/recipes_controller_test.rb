require "test_helper"

describe RecipesController do
  it "should get root" do
    get root_path
    must_respond_with :success
  end

  describe "Index" do
    it "should get index" do
      VCR.use_cassette("index_action") do
        get recipes_path, params: {search: "pineapple"}
        must_respond_with :success
      end
    end

    it "should redirect to root if no results" do
      VCR.use_cassette("index_action") do
        get recipes_path, params: {search: "jfhskfjhdksfjheuy"}
        must_redirect_to root_path

        get recipes_path, params: {search: ""}
        must_redirect_to root_path
      end
    end
  end

  describe "Show" do
    it "should get show" do
      VCR.use_cassette("show") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_637913ec61d9da69eb451818c3293df2"
        get recipe_path("label", uri: uri)
        must_respond_with :success
      end
    end

    it "show should 404 if given bogus data" do
      VCR.use_cassette("show") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#SUPERBOGUS"
        get recipe_path("label", uri: uri)
        must_respond_with :not_found
      end
    end
  end
end
