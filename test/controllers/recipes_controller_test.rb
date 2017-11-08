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
        must_redirect_to root_path
      end
    end
  end
end
