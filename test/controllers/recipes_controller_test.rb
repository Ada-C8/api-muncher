require "test_helper"

describe RecipesController do

  describe "homepage" do

    it "must get home page" do
      get root_path
      must_respond_with :success
    end
  end

  it "must get results if any" do
    VCR.use_cassette("recipes") do
      get root_path(q: "chicken")
      must_respond_with :success
    end
  end

  it "must get homepage even if no param" do
    VCR.use_cassette("recipes") do
      get root_path(q: "")
      must_respond_with :success
    end
  end

  it "must get page even if invalid param" do
    VCR.use_cassette("recipes") do
      get root_path(q: "blah blah blah ")
      must_respond_with :success
    end
  end

  describe "show" do
    it "shows a page for a recipe that exists" do
      VCR.use_cassette("recipes") do
        id = "http://www.edamam.com/ontologies/edamam.owl#recipe_8275bb28647abcedef0baaf2dcf34f8b"
        get root_path(id: id)
        must_respond_with :success
      end
    end
  end

  it "renders 404 if the recipe is not found" do
      VCR.use_cassette("recipes") do
        invalid_id = "blah blah blah"
        get recipe_path(id: invalid_id)

        must_respond_with :missing
      end
    end
end
