require "test_helper"

describe RecipesController do
  describe "root" do
    it "returns success for root page" do
      get root_path

      must_respond_with :success
    end
  end

  describe "index" do
    it "returns success for given search" do
      VCR.use_cassette("recipes") do
        search = {
          query: "fish"
        }

      get recipes_path, params: search[:query]

      must_respond_with :success

      end
    end

    it "returns success for blank or invalid search" do
      VCR.use_cassette("recipes") do
        search = {
          query: ""
        }

        get recipes_path, params: search[:query]

        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "returns success for a recipe" do
      VCR.use_cassette("recipe") do
        uri = "637913ec61d9da69eb451818c3293df2"

        get recipe_path(uri)

        must_respond_with :success
      end
    end

    it "returns not_found for invalid recipe id" do
      VCR.use_cassette("not_found") do
        uri = "invalid_id"

        get recipe_path(uri)

        must_respond_with :not_found
      end
    end
  end

end
