require 'test_helper'


class RecipesControllerTest < ActionDispatch::IntegrationTest

describe "RecipesController" do

  describe "home" do

    it "can get home page" do
      get root_path
      must_respond_with :success
    end
  end

  describe "index" do
    it "can get a list of recipes" do
      VCR.use_cassette("recipes") do
        get root_path("rice")
        must_respond_with :success
      end
    end

    it "will stay on root with no search params" do
      VCR.use_cassette("recipes") do
        get root_path("")
        must_respond_with :success
      end
    end
  end

  describe "show" do
    it "can show a recipe that exists" do
      VCR.use_cassette("recipes") do
        recipe_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f1c853a77986214680bbdd424883499a"
        get recipe_show_path("Herbes de Provence Rotisserie Chickens"), params:{uri: recipe_uri}

        must_respond_with :success
      end
    end

    # it "will render 404 if recipe isn't found" do
    #   VCR.use_cassette("recipes") do
    #     recipe_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f1"
    #     recipe_uri = URI.encode(recipe_uri)
    #     get recipe_show_path("recipe"), params:{uri: recipe_uri}
    #     must_respond_with :not_found
    #   end
    # end
  end
end
end
