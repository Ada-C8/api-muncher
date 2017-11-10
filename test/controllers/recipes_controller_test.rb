require "test_helper"
require_dependency '../../lib/muncher_api_wrapper'
require_dependency '../../lib/recipe'


describe RecipesController do
  describe "index" do
    it "returns success when a valid word is given" do
      VCR.use_cassette("recipes") do
        search = {
          word: "pollo",
          page: 1
        }
        get recipes_path, params: search
        flash[:status].must_equal :success
        flash[:message].must_equal "Estas son las recetas encontradas"
      end
    end

    it "returns not found when an invalid word is given" do
      VCR.use_cassette("recipes") do
        search = {
          word: "qw",
          page: 1
        }
        get recipes_path, params: search
        flash[:status].must_equal :not_found
        flash[:message].must_equal "No hay recetas con la palabra qw"
      end
    end

    it "returns not found when an invalid page number is given" do
      VCR.use_cassette("recipes") do
        search = {
          word: "pollo",
          page: 0
        }
        get recipes_path, params: search
        must_respond_with :not_found

        # flash[:status].must_equal :not_found
        # flash[:message].must_equal "No hay información disponible en esta página"
      end
    end
  end

  describe "show" do
    it "can show one recipe" do
      VCR.use_cassette("one_recipe") do
        search = {
          uri: uri = "6893cc673c96d3f26910052de21f2d89"
        }
        get recipe_path("6893cc673c96d3f26910052de21f2d89"), params: search
        must_respond_with :success
      end
    end

    it "gives not found for invalid recipe id" do
        VCR.use_cassette("bad_uri") do
          get recipe_path("invalid_uri")
          must_respond_with :not_found
        end
      end
    end


end
