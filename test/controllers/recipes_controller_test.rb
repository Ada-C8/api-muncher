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
        get recipes_path(ingredient)
        must_respond_with :success
      end
    end

    it "responds with success if it returns 0 results" do
      VCR.use_cassette("index_action") do
        get recipes_path("jlk") do
          must_respond_with :success
        end
      end
    end

  end



end
