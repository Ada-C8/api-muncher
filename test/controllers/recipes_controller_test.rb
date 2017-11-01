require "test_helper"

describe RecipesController do
  describe "index" do
    it "can get a list of recipes" do
      VCR.use_cassette("index_action") do


      end
    end

    it "defualts a list of recipes if a search is not done before" do
      VCR.use_cassette("index_action") do


      end
    end

    it "successfully loads page with many recipes" do


    end

    it "loads page with no recipes" do


    end

    it "loads page with a request with no recipes" do


    end
  end

  describe "show" do
    it "finds a recipe" do


    end

    it "renders a 404 if the recipe is not found" do


    end

    it "successfully loads the page" do


    end
  end
end
