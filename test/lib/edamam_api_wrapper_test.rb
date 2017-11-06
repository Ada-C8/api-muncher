require 'test_helper'

describe EdamamApiWrapper do

  describe "search_recipes" do

    it "can list recipes" do
      VCR.use_cassette("get_recipes") do
        search = "rice"
        recipes = EdamamApiWrapper.search_recipes(search)

        recipes.must_be_instance_of Array

        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "returns empty array with blank search" do
      VCR.use_cassette("get_recipes") do
        search = ""
        recipes = EdamamApiWrapper.search_recipes(search)

        recipes.must_equal []
      end
    end
  end

  describe "show_recipe" do
    it "gets a specific recipe object" do
      VCR.use_cassette("get_recipes") do
        uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f1c853a77986214680bbdd424883499a"
        recipe = EdamamApiWrapper.show_recipe(uri)
        recipe.must_be_instance_of Recipe
        recipe.label.must_equal "Herbes de Provence Rotisserie Chickens"
      end
    end
  end
end
